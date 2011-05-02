#!/usr/bin/env bash
set -e

SRC_FILE=$TOP_DIR/gcc-${GCC_VERSION}${MY_REVISION}_rubenvb
BIN_FILE=$TOP_DIR/$HOST-gcc-${GCC_VERSION}${MY_REVISION}_rubenvb.zip
if [ -f $BIN_FILE ]
then
    rm -f $BIN_FILE
fi

echo "--> Zipping binaries"
cd $PREFIX/..
zip -D -r -9 $BIN_FILE $SHORTNAME > $LOG_DIR/zipping.log

if [ -f $SRC_FILE ]
then
    echo "--> Source file already exists"
else
	echo "--> Zipping up sources"
	cd $TOP_DIR
	tar --lzma -cf $SRC_FILE.tar.lzma --exclude='*.git' --exclude='*.svn' src scripts *.sh
fi


