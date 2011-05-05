#!/usr/bin/env bash
set -e

export PATH=$PREFIX/bin:$PATH
if [ -f $MARKER_DIR/gcc_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/gcc/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                              --with-libiconv-prefix=$GCC_LIBS --with-libexpat-prefix=$GCC_LIBS \
                              --with-gmp=$GCC_LIBS --with-mpfr=$GCC_LIBS --with-mpc=$GCC_LIBS --with-ppl=$GCC_LIBS --with-cloog=$GCC_LIBS \
                              --enable-languages=$GCC_LANGUAGES --enable-libgomp --enable-checking=release --enable-cloog-backend=isl \
                              --enable-fully-dynamic-string --enable-sjlj-exceptions --enable-libstdcxx-debug \
                              $GNU_EXTRA_OPTIONS \
                              $GNU_MULTILIB $SHARED \
                              $GNU_WIN32_OPTIONS \
                              CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                              > $LOG_DIR/gcc_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch $MARKER_DIR/gcc_configure.marker

if [ -f $MARKER_DIR/gcc_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/gcc_build.log 2>&1 || exit 1
fi
touch $MARKER_DIR/gcc_build.marker

if [ -f $MARKER_DIR/gcc_install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install-strip > $LOG_DIR/gcc_install.log 2>&1 || exit 1
fi
touch $MARKER_DIR/gcc_install.marker
