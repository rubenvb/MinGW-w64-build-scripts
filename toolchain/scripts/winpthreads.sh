#!/usr/bin/env bash
set -e

if [ -f winpthreads_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/winpthreads/configure --host=$HOST --build=$BUILD --prefix=$PREFIX \
                                      CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                      > $LOG_DIR/winpthreads_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch winpthreads_configure.marker
    
if [ -f winpthreads_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/winpthreads_build.log 2>&1 || exit 1
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