#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-w64-mingw32
export TARGET=x86_64-w64-mingw32
export BUILD=x86_64-redhat-linux
export EXESUFFIX=".exe"
export SHORT_NAME=mingw64
export LONG_NAME=mingw64mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND='-DMS_WIN64'

# versions
. ./versions.sh

# directories
export TOP_DIR=`pwd`
export SRC_DIR=$TOP_DIR/src
export BUILD_DIR=$TOP_DIR/$LONG_NAME
export PACKAGE_DIR=$TOP_DIR/packages
export LOG_DIR=$BUILD_DIR/logs
export PREREQ_INSTALL=$BUILD_DIR/prereq_install
export SCRIPTS=$TOP_DIR/scripts
export GCC_SRC=$BUILD_DIR/gcc-src
export MINGW_W64_SRC=$SRC_DIR/mingw-w64/$MINGW_W64_VERSION
export PREFIX=$BUILD_DIR/$SHORT_NAME
DIRS_TO_MAKE="$BUILD_DIR $BUILD_DIR/gcc $LOG_DIR
              $GCC_SRC $GCC_SRC/libiconv $GCC_SRC/gmp $GCC_SRC/mpfr $GCC_SRC/mpc $GCC_SRC/ppl $GCC_SRC/cloog
              $PREFIX $PREFIX/mingw/include $PREFIX/$TARGET/include
              $PREREQ_INSTALL $PREREQ_INSTALL/lib $PREREQ_INSTALL/include
              $PACKAGE_DIR $PACKAGE_DIR/$HOST"
mkdir -p $DIRS_TO_MAKE

# combined gcc tree symlinks
if [ -f $GCC_SRC/symlinks.marker ]
then
    echo "-> GCC combined tree already in place"
else
    echo "-> Creating GCC combined tree symlinks"
    ln -s $SRC_DIR/gcc/* $GCC_SRC/
    ln -s $SRC_DIR/libiconv-$LIBICONV_VERSION/* $GCC_SRC/libiconv/
    ln -s $SRC_DIR/gmp-$GMP_VERSION/* $GCC_SRC/gmp/
    ln -s $SRC_DIR/mpfr-$MPFR_VERSION/* $GCC_SRC/mpfr/
    ln -s $SRC_DIR/mpc-$MPC_VERSION/* $GCC_SRC/mpc/
    ln -s $SRC_DIR/ppl-$PPL_VERSION/* $GCC_SRC/ppl/
    ln -s $SRC_DIR/cloog-$CLOOG_VERSION/* $GCC_SRC/cloog/
    echo "-> Done"
fi
touch $GCC_SRC/symlinks.marker

# Projects to be built, in the right order
PREGCC_STEPS="mingw-w64-headers
              binutils
              mingw-w64-crt
              winpthreads"
POSTGCC_STEPS="expat
               python
               gdb
               make
               llvm-clang
               cleanup
               zipping"
cd $BUILD_DIR
mkdir -p $PREGCC_STEPS
mkdir -p $POSTGCC_STEPS
cd $TOP_DIR

# native compiler options
export GNU_WIN32_OPTIONS='--disable-win32-registry --disable-rpath --disable-werror'

## Build steps
MAKE_OPTS='-j2'
# prepare for GCC
for step in $PREGCC_STEPS
do
    cd $BUILD_DIR/$step
    echo "-> $step"
    . $SCRIPTS/$step.sh || exit 1
    cd $TOP_DIR
done
# build GCC
cd $BUILD_DIR/gcc
echo "-> GCC combined tree"
. $SCRIPTS/gcc-combined.sh || exit 1
cd $TOP_DIR
# build the rest
for step in $POSTGCC_STEPS
do
    cd $BUILD_DIR/$step
    echo "-> $step"
    . $SCRIPTS/$project.sh || exit 1
    cd $TOP_DIR
done


# add cross toolchains to PATH
#. ./crosstoolchainpaths.sh

# common options
#. ./scripts/common.sh
