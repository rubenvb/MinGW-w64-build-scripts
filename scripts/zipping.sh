#!/usr/bin/env bash
set -e

FILE = $TOPDIR/$HOST-gcc-${GCC_VERSION}_rubenvb.zip

if [ -f $FILE ]
then
    rm -f $FILE
fi

echo "--> Zipping up"
zip -9 $FILE /mingw64
