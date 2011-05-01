#!/usr/bin/env bash
set -e

FILE=$TOP_DIR/$HOST-gcc-${GCC_VERSION}_rubenvb.zip

if [ -f $FILE ]
then
    rm -f $FILE
fi

echo "--> Zipping up"
cd $PREFIX/..
zip -D -r -9 $FILE $SHORTNAME > $LOG_DIR/zipping.log

