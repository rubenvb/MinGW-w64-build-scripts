#!/usr/bin/env bash
set -e

# build the crt with the new tools
export PATH=$PREFIX/bin:$PATH

if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $MINGW_W64_SRC/mingw-w64-crt/configure --host=$TARGET --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                                              $CRT_MULTILIB \
                                              --enable-sdk=all --enable-secure-api --enable-wildcard \
                                              CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                              > $LOG_DIR/mingw-w64_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch configure.marker

if [ -f build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/mingw-w64-crt_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install > $LOG_DIR/mingw-w64-crt_install.log 2>&1 || exit 1
fi
touch install.marker
