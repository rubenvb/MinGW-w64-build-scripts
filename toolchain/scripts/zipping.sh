#!/usr/bin/env bash
set -e

SRC_FILE=$TOP_DIR/gcc-${GCC_VERSION}${MY_REVISION}_rubenvb.tar.lzma
if [ "$HOST" == "$TARGET" ]
then
    BIN_COMPRESS="zip -D -r -q -9"
    BIN_FILE=$TOP_DIR/$HOST-gcc-${GCC_VERSION}${MY_REVISION}_rubenvb.zip
else
    BIN_COMPRESS="tar --lzma -cf"
    BIN_FILE=$TOP_DIR/$TARGET-gcc-${GCC_VERSION}${MY_REVISION}-linux_rubenvb.tar.lzma
fi

if [ -f $BIN_FILE ]
then
    echo "--> Binary file already exists"
else
    echo "--> Zipping binaries"
    cd $PREFIX/..
    $BIN_COMPRESS $BIN_FILE $SHORT_NAME
fi



if [ -f $SRC_FILE ]
then
    echo "--> Source file already exists"
else
	echo "--> Zipping sources"
	cd $TOP_DIR
	tar --lzma -cf $SRC_FILE --exclude='*.git' --exclude='*.svn' src scripts *.sh
fi

