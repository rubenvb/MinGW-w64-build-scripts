#!/usr/bin/env bash
set -e

if [ -f $MARKER_DIR/pthreads.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
	unzip -o $SRC_DIR/pthreads-$TARGET.zip -d . > $LOG_DIR/pthreads.log 2>&1 || exit 1
	cp -r ./* $PREFIX
fi
touch $MARKER_DIR/pthreads.marker
    
