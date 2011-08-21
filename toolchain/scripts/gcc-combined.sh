#!/usr/bin/env bash
set -e

#--with-libiconv --with-gmp --with-mpfr --with-mpc --with-ppl --with-cloog --enable-cloog-backend=isl
#export PATH=$PREFIX/bin:$PATH
if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $GCC_SRC/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                          --enable-cloog-backend=isl --with-host-libstdcxx='-lsupc++ -lstdc++' \
                          --enable-shared --enable-static --enable-threads=win32 \
                          --enable-languages=all,obj-c++ --enable-libgomp --enable-checking=release \
                          --enable-fully-dynamic-string --enable-sjlj-exceptions \
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
