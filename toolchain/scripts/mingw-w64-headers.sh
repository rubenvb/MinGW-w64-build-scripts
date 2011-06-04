#!/usr/bin/env bash
set -e

if [ -f mingw-w64-headers_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/mingw-w64/mingw-w64-headers/configure --host=$TARGET --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                                                      $CRT_MULTILIB \
                                                      --enable-sdk=all --enable-secure-api \
                                                      CFLAGS="$BUILD_CFLAGS_LTO" LFLAGS="$BUILD_LFLAGS_LTO" \
                                                      > $LOG_DIR/mingw-w64_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch mingw-w64-headers_configure.marker

if [ -f mingw-w64-headers_install.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
	make $MAKE_OPTS install > $LOG_DIR/mingw-w64-headers_install.log 2>&1 || exit 1
fi
touch mingw-w64-headers_install.marker
