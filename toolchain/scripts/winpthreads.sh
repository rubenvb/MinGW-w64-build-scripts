#!/usr/bin/env bash
set -e

# build winpthreads with the new tools
export PATH=$PREFIX/bin:$PATH

if [ -f winpthreads_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS -fGNUMakefile clean-GC CROSS=$TARGET- > $LOG_DIR/winpthreads_build.log 2>&1 || exit 1
fi
touch winpthreads_build.marker

if [ -f winpthreads_install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install > $LOG_DIR/winpthreads_install.log 2>&1 || exit 1
fi
touch winpthreads_install.marker