#!/usr/bin/env bash
set -e

if [ -f $MARKER_DIR/pthreads.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
    if [[ GNU_MULTILIB == "--disable-multilib" ]]
    then
	    unzip -o $SRC_DIR/pthreads-$TARGET.zip -d . > $LOG_DIR/pthreads.log 2>&1 || exit 1
	else
        unzip -o $SRC_DIR/pthreads-x86_64-w64-mingw32.zip -d . > $LOG_DIR/pthreads64.log 2>&1 || exit 1
        unzip -o $SRC_DIR/pthreads-i686-w64-mingw32.zip -d . > $LOG_DIR/pthreads32.log 2>&1 || exit 1
    fi
    cp -r ./* $PREFIX
fi
touch $MARKER_DIR/pthreads.marker
    
