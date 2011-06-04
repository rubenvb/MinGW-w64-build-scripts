#!/usr/bin/env bash
set -e

SRC_FILE=$TOP_DIR/gcc-${GCC_VERSION}${MY_REVISION}_rubenvb.tar.lzma
BIN_FILE=$TOP_DIR/$HOST-gcc-${GCC_VERSION}${MY_REVISION}_rubenvb.zip

if [ -f $BIN_FILE ]
then
    echo "--> Binary file already exists"
else
    echo "--> Zipping binaries"
    cd $PREFIX/..
    zip -D -r -9 $BIN_FILE $SHORT_NAME > $LOG_DIR/zipping.log
fi



if [ -f $SRC_FILE ]
then
    echo "--> Source file already exists"
else
	echo "--> Zipping sources"
	cd $TOP_DIR
	tar --lzma -cf $SRC_FILE --exclude='*.git' --exclude='*.svn' src scripts *.sh
fi

