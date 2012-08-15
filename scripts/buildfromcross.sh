#!/usr/bin/env bash
set -e

# common settings
echo "Executing preliminary setup"
# build settings
. ./scripts/settings.sh || exit 1
# version info
echo "-> Loading version info"
. ./scripts/versions.sh || exit 1
# set up and create directories
echo "-> Setting up directories"
. ./scripts/directories.sh || exit 1

# native compiler options
export MAKE_AR="AR=$HOST-ar" # necessary for libiconv+x86_64-apple-darwin10
if [ "$HOST" = "i686-w64-mingw32" ] || [ "$HOST" = "i686-pc-cygwin" ]
then
  export HOST_LDFLAGS_BINUTILS="$HOST_LDFLAGS -Wl,--large-address-aware"
fi

export GNU_WIN32_OPTIONS="--disable-win32-registry --disable-rpath --disable-werror --with-libiconv-prefix=$PREREQ_INSTALL"

# Projects to be built, in the right order
PREGCC_STEPS="mingw-w64-headers
              binutils
              mingw-w64-crt
              winpthreads"
GNU_PREREQ="libiconv
            gmp mpfr mpc
            isl ppl cloog"
if [ "$HOST" = "i686-w64-mingw32" ] || [ "$HOST" = "x86_64-w64-mingw32" ]
then
  GNU_PREREQ="expat $GNU_PREREQ"
  POSTGCC_STEPS="python
                 gdb
                 make"
fi
POSTGCC_STEPS="$POSTGCC_STEPS
               cleanup
               licenses
               zipping"
cd $PREREQ_DIR
mkdir -p $GNU_PREREQ
cd $BUILD_DIR
mkdir -p $PREGCC_STEPS
mkdir -p gcc
mkdir -p $POSTGCC_STEPS

#copy GCC environment setup script
if [ "$TARGET_ARCH" = "i686" ]
then
  cp $TOP_DIR/envsetup/mingw32env.cmd $PREFIX/
elif [ "$TARGET_ARCH" = "x86_64" ]
then
  cp $TOP_DIR/envsetup/mingw64env.cmd $PREFIX/
fi

# Build
for step in $GNU_PREREQ
do
  echo "-> $step for $HOST"
  cd $PREREQ_DIR/$step
  . $SCRIPTS/$step.sh || exit 1
done
for step in $PREGCC_STEPS
do
  cd $BUILD_DIR/$step
  echo "-> $step"
  . $SCRIPTS/$step.sh || exit 1
done
# build GCC
cd $BUILD_DIR/gcc
echo "-> GCC: Full compiler suite"
. $SCRIPTS/gcc.sh || exit 1
# build the rest
for step in $POSTGCC_STEPS
do
  cd $BUILD_DIR/$step
  echo "-> $step"
  . $SCRIPTS/$step.sh || exit 1
done
