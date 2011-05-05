#!/usr/bin/env bash
set -e

if [ -f $MARKER_DIR/pthreads.marker ]
then
    echo "--> Already installed"
else
	echo "--> Preparing"
    if [[ $GNU_MULTILIB == "--disable-multilib" ]]
    then
	    unzip -o $SRC_DIR/pthreads-$TARGET.zip -d . > $LOG_DIR/pthreads.log 2>&1 || exit 1
    else
        unzip -o $SRC_DIR/pthreads-x86_64-w64-mingw32.zip -d . > $LOG_DIR/pthreads.log 2>&1 || exit 1
        unzip -o $SRC_DIR/pthreads-i686-w64-mingw32.zip -d . > $LOG_DIR/pthreads.log 2>&1 || exit 1
        
        if [[ $TARGET == "x86_64-w64-mingw32" ]]
        then
            mkdir x86_64-w64-mingw32/lib32
            mv i686-w64-mingw32/lib/* x86_64-w64-mingw32/lib32
            rm -rf i686-w64-mingw32
        else
            mkdir i686-w64-mingw32/lib64
            mv x86_64-w64-mingw32/lib/* i686-w64-mingw32/lib64
            rm -rf x86_64-w64-mingw32
        fi
    fi
    echo "--> Installing"
    cp -r ./* $PREFIX
fi
touch $MARKER_DIR/pthreads.marker
    
