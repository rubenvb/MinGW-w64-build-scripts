#!/usr/bin/env bash
set -e

export PATH=$PREFIX/bin:$PATH
if [ -f $MARKER_DIR/gcc-c_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/gcc/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                              --with-libiconv-prefix=$GCC_LIBS --with-libexpat-prefix=$GCC_LIBS --with-gmp=$GCC_LIBS --with-mpfr=$GCC_LIBS --with-mpc=$GCC_LIBS \
                              --enable-languages=c --enable-lto --enable-libgomp --enable-checking=release \
                              --enable-fully-dynamic-string --enable-nls \
                              --disable-multilib --enable-shared \
                              $GCC_WIN32_OPTIONS \
                              CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                              > $LOG_DIR/gcc-c_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch $MARKER_DIR/gcc-c_configure.marker

if [ -f $MARKER_DIR/gcc-c_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS all-gcc > $LOG_DIR/gcc-c_build.log 2>&1 || exit 1
fi
touch $MARKER_DIR/gcc-c_build.marker

if [ -f $MARKER_DIR/gcc-c_install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install-gcc > $LOG_DIR/gcc-c_install.log 2>&1 || exit 1
fi
touch $MARKER_DIR/gcc-c_install.marker
