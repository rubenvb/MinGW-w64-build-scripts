#!/usr/bin/env bash
# sets and creates directories used elsewhere
# requires LONG_NAME, SHORT_NAME, HOST, MINGW_W64_VERSION
set -e

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
              $BUILD_DIR/mingw-w64-crt $BUILD_DIR/winpthreads
              $PREFIX $PREFIX/mingw/include $PREFIX/$TARGET/include
              $PREREQ_INSTALL $PREREQ_INSTALL/lib $PREREQ_INSTALL/include
              $PACKAGE_DIR $PACKAGE_DIR/$HOST"
mkdir -p $DIRS_TO_MAKE

# binutils
export BINUTILS_SRC=$BUILD_DIR/binutils-src
mkdir -p $BINUTILS_SRC $BINUTILS_SRC/libiconv

# native gdb build
if [ "$HOST" == "i686-w64-mingw32" ] || [ "$HOST" == "x86_64-w64-mingw32" ]
then
    export GDB_SRC=$BUILD_DIR/gdb-src
    mkdir -p $GDB_SRC $GDB_SRC/libiconv
fi
    