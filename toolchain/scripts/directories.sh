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
export FAKEGCC_PATH=$SCRIPTS/fakegcc
export GCC_SRC=$BUILD_DIR/gcc-src
export MINGW_W64_SRC=$SRC_DIR/mingw-w64/$MINGW_W64_VERSION
export PREFIX=$BUILD_DIR/$SHORT_NAME
DIRS_TO_MAKE="$BUILD_DIR $BUILD_DIR/gcc $LOG_DIR
              $BUILD_DIR/mingw-w64-crt $BUILD_DIR/winpthreads
              $PREFIX $PREFIX/mingw/include $PREFIX/$TARGET/include
              $PREREQ_INSTALL $PREREQ_INSTALL/lib $PREREQ_INSTALL/include
              $PACKAGE_DIR $PACKAGE_DIR/$HOST"
mkdir -p $DIRS_TO_MAKE
