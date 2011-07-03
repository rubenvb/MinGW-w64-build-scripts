#!/usr/bin/env bash
set -e

# build winpthreads with the new tools
export PATH=$PREFIX/bin:$PATH

if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/winpthreads/configure --host=$TARGET --build=$BUILD --prefix=$PREFIX/$TARGET \
                                      --enable-shared --enable-static \
                                      CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                      > $LOG_DIR/winpthreads_configure.log 2>&1 || exit 1
fi
touch configure.marker

if [ -f build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/winpthreads_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install > $LOG_DIR/winpthreads_install.log 2>&1 || exit 1
fi
touch install.marker
