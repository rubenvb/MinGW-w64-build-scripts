#!/usr/bin/env bash
set -e

if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh ../../src/mpir-$MPIR_VERSION/configure --host=$HOST --build=$BUILD --prefix=$GCC_LIBS \
                                              $STATIC --enable-cxx --enable-gmpcompat \
                                              CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                              CC="$CROSS_CC" CXX="$CROSS_CXX" \
                                              > $LOG_DIR/mpir_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch configure.marker

if [ -f build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/mpir_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install > $LOG_DIR/mpir_install.log 2>&1  || exit 1
fi
touch install.marker
