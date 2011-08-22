#!/usr/bin/env bash
set -e

# add C compiler+binutils to PATH
# build the crt with the new tools
if [ "$HOST" == "i686-gnu-linux" ] && [ "$HOST" == "x86_64-gnu-linux" ]
then
    export PATH=$PREFIX/bin:$PATH
fi

if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $GCC_SRC/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                          --with-libexpat-prefix=$PREREQ_INSTALL --enable-cloog-backend=isl --with-host-libstdcxx='-lstdc++' \
                          --enable-shared --enable-static --enable-threads=win32 \
                          --disable-multilib \
                          --enable-languages=all,obj-c++ --enable-libgomp --enable-libgjc \
                          --enable-fully-dynamic-string --enable-sjlj-exceptions \
                          --disable-nls --disable-werror --enable-checking=release \
                          $GNU_WIN32_OPTIONS \
                          > $LOG_DIR/gcc_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch configure.marker

if [ -f build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/gcc_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install-strip > $LOG_DIR/gcc_install.log 2>&1 || exit 1
fi
touch install.marker
