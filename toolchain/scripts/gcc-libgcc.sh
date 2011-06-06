#!/usr/bin/env bash
set -e

export PATH=$PREFIX/bin:$PATH

cd $BUILD_DIR/gcc-c

if [ -f gcc-libgcc_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS all-target-libgcc > $LOG_DIR/gcc-c_build.log 2>&1 || exit 1
fi
touch gcc-libgcc_build.marker

if [ -f gcc-libgcc_install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install-target-libgcc > $LOG_DIR/gcc-c_install.log 2>&1 || exit 1
fi
touch gcc-libgcc_install.marker
