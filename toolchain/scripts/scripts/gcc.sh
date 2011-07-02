#!/usr/bin/env bash
set -e

export PATH=$PREFIX/bin:$PATH
if [ -f gcc_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $GCC_SRC/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                          $GCC_PREREQUISITES \
                          --enable-shared --enable-static --enable-threads=posix \
                          --enable-languages=$GCC_LANGUAGES --enable-libgomp --enable-checking=release \
                          --enable-fully-dynamic-string --enable-sjlj-exceptions --enable-libstdcxx-debug \
                          $GNU_EXTRA_OPTIONS \
                          $GNU_MULTILIB \
                          $GNU_WIN32_OPTIONS \
                          CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                          > $LOG_DIR/gcc_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch gcc_configure.marker

if [ -f gcc_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/gcc_build.log 2>&1 || exit 1
fi
touch gcc_build.marker

if [ -f gcc_install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install-strip > $LOG_DIR/gcc_install.log 2>&1 || exit 1
fi
touch gcc_install.marker
