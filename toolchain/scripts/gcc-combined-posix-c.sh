#!/usr/bin/env bash
set -e

if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $GCC_SRC/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                          --with-libexpat-prefix=$PREREQ_INSTALL --enable-cloog-backend=isl --with-host-libstdcxx='-lstdc++ -lsupc++ -lm -lgcc_eh' \
                          --enable-shared --enable-static --enable-threads=posix \
                          --disable-multilib \
                          --enable-languages=c,lto,c++,fortran,objc,obj-c++ --enable-libgomp --enable-libgjc \
                          --enable-fully-dynamic-string --enable-sjlj-exceptions \
                          --disable-nls --disable-werror --enable-checking=release \
                          $GNU_WIN32_OPTIONS \
                          > $LOG_DIR/gcc-posix_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch configure.marker

if [ -f build-c.marker ]
then
    echo "--> Already built"
else
    echo "--> Building gcc"
    make $MAKE_OPTS all-gcc > $LOG_DIR/gcc-posix-c_build.log 2>&1 || exit 1
    echo "--> Building libgcc"
    make $MAKE_OPTS all-target-libgcc > $LOG_DIR/gcc-posix-libgcc_build.log 2>&1 || exit 1
fi
touch build-c.marker

if [ -f install-c.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing gcc"
    make $MAKE_OPTS install-gcc > $LOG_DIR/gcc-c_install.log 2>&1 || exit 1
    echo "--> Installing libgcc"
    make $MAKE_OPTS install-target-libgcc > $LOG_DIR/gcc-posix-libgcc_install.log 2>&1 || exit 1
fi
touch install-c.marker
