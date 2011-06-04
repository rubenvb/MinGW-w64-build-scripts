#!/usr/bin/env bash
set -e

if [ -f install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Unzipping"
    unzip -o $SRC_DIR/python-$TARGET.zip -d . > $LOG_DIR/python.log 2>&1 || exit 1
    
    echo "--> Copying files"
    cp bin/python27.dll $PREFIX/bin/python27.dll
    mkdir -p $PREFIX/bin/lib
    cp -r lib/python27/* $PREFIX/bin/lib
fi
touch install.marker
