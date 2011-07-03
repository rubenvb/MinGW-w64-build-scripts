#!/usr/bin/env bash
set -e

export PATH=$PREFIX/bin:$PATH
if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $GCC_SRC/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                          $GCC_PREREQUISITES \
                          --enable-threads=win32 \
                          --enable-languages=c --enable-libgomp --enable-checking=release \
                          --enable-fully-dynamic-string \
                          $GNU_EXTRA_OPTIONS \
                          $GNU_MULTILIB $SHARED \
                          $GNU_WIN32_OPTIONS \
                          CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                          > $LOG_DIR/gcc-c_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch configure.marker

if [ -f build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS all-gcc > $LOG_DIR/gcc-c_build.log 2>&1 || exit 1
    #make $MAKE_OPTS all-target-libgcc > $LOG_DIR/gcc-c_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install-gcc > $LOG_DIR/gcc-c_install.log 2>&1 || exit 1
    #make $MAKE_OPTS install-target-libgcc > $LOG_DIR/gcc-c_install.log 2>&1 || exit 1
fi
touch install.marker
