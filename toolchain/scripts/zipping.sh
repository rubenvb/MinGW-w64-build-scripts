#!/usr/bin/env bash
set -e

SRC_FILE=$PACKAGE_DIR/gcc-${GCC_VERSION}${MY_REVISION}_rubenvb.tar.lzma
if [ "$HOST" == "x86_64-w64-mingw32" ] || [ "$HOST" == "i686-w64-mingw32" ]
then
    BIN_COMPRESS="7za -l -bd -mx9 a"
    BIN_FILE=$PACKAGE_DIR/$HOST/$TARGET-gcc-${GCC_VERSION}${MY_REVISION}_rubenvb.7z
    BIN_FILE_CLANG=$PACKAGE_DIR/$HOST/$TARGET-clang-${CLANG_VERSION}${MY_CLANG_REVISION}_rubenvb.7z
else
    if [ "$HOST" == "x86_64-linux-gnu" ] || [ "$HOST" == "i686-linux-gnu" ]
    then
        PLATFORM_SUFFIX="linux"
    elif [ "$HOST" == "x86_64-apple-darwin10" ] || [ "$HOST" == "i686-apple-darwin10" ]
    then
        PLATFORM_SUFFIX="mac"
    elif [ "$HOST" == "i686-pc-cygwin" ]
    then
        PLATFORM_SUFFIX="cygwin"
    else
        echo "-> unknown host set: $HOST"
    fi
    BIN_COMPRESS="tar --lzma -cf"
    BIN_FILE=$PACKAGE_DIR/$HOST/$TARGET-gcc-${GCC_VERSION}${MY_REVISION}-${PLATFORM_SUFFIX}_rubenvb.tar.lzma
    #BIN_FILE_CLANG=$TOP_DIR/$HOST-clang-${CLANG_VERSION}${MY_CLANG_REVISION}-linux_rubenvb.7z
fi

if [ -f $BIN_FILE ]
then
    echo "--> Binary file already exists"
else
    echo "--> Zipping binaries"
    cd $PREFIX/..
    # Base package
    echo "---> Base package"
    $BIN_COMPRESS $BIN_FILE $SHORT_NAME

    if [ "$HOST" == "x86_64-w64-mingw32" ] || [ "$HOST" == "i686-w64-mingw32" ]
    then
        # Clang addon package
        echo "---> Clang addon package"
        mv $PREFIX $PREFIX-base
        mv $PREFIX-clang $PREFIX
        $BIN_COMPRESS $BIN_FILE_CLANG $SHORT_NAME
        mv $PREFIX $PREFIX-clang
        mv $PREFIX-base $PREFIX
    fi
fi

if [ -f $SRC_FILE ]
then
    echo "--> Source file already exists"
else
    echo "--> Zipping sources"
    cd $TOP_DIR
    tar --lzma -cf $SRC_FILE --exclude='*.git' --exclude='*.svn' src scripts patches *.sh
fi

