#!/usr/bin/env bash
set -e

export PATH=$PREFIX/bin:$PATH
if [ -f build-libgcc.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS all-target-libgcc > $LOG_DIR/gcc-c_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install-libgcc.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install-target-libgcc > $LOG_DIR/gcc-c_install.log 2>&1 || exit 1
fi
touch install.marker
