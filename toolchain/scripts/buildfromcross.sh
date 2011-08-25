#!/usr/bin/env bash
set -e

# native compiler options
export GNU_WIN32_OPTIONS='--disable-win32-registry --disable-rpath --disable-werror'
if [ "$HOST" == "i686-w64-mingw32" ] || [ "$HOST" == "i686-pc-cygwin" ]
then
    export BUILD_LDFLAGS="$BUILD_LDFLAGS -Wl,--large-address-aware"
fi

# common settings
echo "Executing preliminary common steps"
. ./scripts/common.sh || exit 1

# Projects to be built, in the right order
PREGCC_STEPS="mingw-w64-headers
              binutils
              mingw-w64-crt
              winpthreads"
if [ "$HOST" == "i686-w64-mingw32" ] || [ "$HOST" == "x86_64-w64-mingw32" ]
then
    POSTGCC_STEPS="expat
                   python
                   gdb
                   make
                   llvm-clang"
fi
POSTGCC_STEPS="$POSTGCC_STEPS
               cleanup
               zipping"
cd $BUILD_DIR
mkdir -p $PREGCC_STEPS
mkdir -p $POSTGCC_STEPS

# Build
for step in $PREGCC_STEPS
do
    cd $BUILD_DIR/$step
    echo "-> $step"
    . $SCRIPTS/$step.sh || exit 1
done
# build GCC
cd $BUILD_DIR/gcc
echo "-> GCC: Full compiler suite"
. $SCRIPTS/gcc-combined.sh || exit 1
# build the rest
for step in $POSTGCC_STEPS
do
    cd $BUILD_DIR/$step
    echo "-> $step"
    . $SCRIPTS/$step.sh || exit 1
done
