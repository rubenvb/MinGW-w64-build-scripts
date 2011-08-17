#!/usr/bin/env bash
set -e

#workaround for linux cross-compilation
if [ "$HOST" == "i686-linux-gnu" ] && [ "$BUILD" == "x86_64-linux-gnu" ]
then
    echo "--> Using GMP configure workaround"
    CROSS_CC='gcc -m32'
    CROSS_CXX='g++ -m32'
elif [ "$BUILD" == "i686-linux-gnu" ] && [ "$HOST" == "x86_64-linux-gnu" ] 
then
    CROSS_CC='gcc -m64'
    CROSS_CXX='g++ -m64'
else
    CC_GMP=
    CXX_GMP=
fi

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
