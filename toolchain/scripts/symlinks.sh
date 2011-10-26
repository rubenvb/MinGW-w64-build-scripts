#!/usr/bin/env bash
set -e

# combined gcc tree symlinks
if [ -f $GCC_SRC/symlinks.marker ]
then
    echo "--> GCC combined tree already in place"
else
    echo "--> Creating GCC combined tree symlinks"
    ln -s $SRC_DIR/gcc/* $GCC_SRC/
    ln -s $SRC_DIR/libiconv-$LIBICONV_VERSION/* $GCC_SRC/libiconv/
    echo "--> Done"
fi
touch $GCC_SRC/symlinks.marker

# combined binutils tree symlinks
if [ -f $BINUTILS_SRC/symlinks.marker ]
then
    echo "--> Binutils+libiconv combined tree already in place"
else
    echo "--> Creating binutils+libiconv combined tree symlinks"
    ln -s $SRC_DIR/binutils/* $BINUTILS_SRC/
    ln -s $SRC_DIR/libiconv-$LIBICONV_VERSION/* $BINUTILS_SRC/libiconv/
    echo "--> Done"
fi
touch $BINUTILS_SRC/symlinks.marker

# combined GDB tree symlinks
if [ "$HOST" == "i686-w64-mingw32" ] || [ "$HOST" == "x86_64-w64-mingw32" ]
then
    if [ -f $GDB_SRC/symlinks.marker ]
    then
        echo "--> GDB+libiconv tree already in place"
    else
        echo "--> Creating GDB+libiconv tree symlinks"
        ln -s $SRC_DIR/gdb/* $GDB_SRC/
        ln -s $SRC_DIR/libiconv-$LIBICONV_VERSION/* $GDB_SRC/libiconv/
        echo "--> Done"
    fi
    touch $GDB_SRC/symlinks.marker
fi