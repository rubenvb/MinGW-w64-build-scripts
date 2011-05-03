#!/usr/bin/env bash
set -e

if [ -f $MARKER_DIR/cleanup.marker ]
then
    echo "--> Already cleaned up"
else
    echo "--> Cleaning up"
    rm -rf $PREFIX/mingw || exit 1
    find . -name "*.la" -exec rm -f {} \;

    echo "--> Stripping Executables"
    find $PREFIX -name "*.exe" -exec rm -f {} \;

    if [[ "$TARGET" == "$HOST" ]]
    then 
        echo "--> Copying DLL's"
        cp $GCC_LIBS/bin/*.dll $PREFIX/bin
    else
        echo "--> No DLL's to copy for cross-compiler"
    fi
fi
touch $MARKER_DIR/cleanup.marker
