#!/usr/bin/env bash
set -e

if [ -f $MARKER_DIR/cleanup.marker ]
then
    echo "--> Already cleaned up"
else
    echo "--> Cleaning up"
    rm -rf $PREFIX/mingw || exit 1
    strip $PREFIX/$TARGET/bin/*$EXESUFFIX
    strip $PREFIX/libexec/gcc/$TARGET/$GCC_VERSION/*$EXESUFFIX
    strip $PREFIX/$TARGET/bin/*$EXESUFFIX
fi
touch $MARKER_DIR/cleanup.marker
