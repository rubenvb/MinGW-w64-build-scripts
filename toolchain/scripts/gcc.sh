#!/usr/bin/env bash
set -e

# add C compiler+binutils to PATH
# if [ "$BUILD_CROSS_FROM_NATIVE" == "true" ]
# then
#     export PATH=$PREFIX/bin:$PATH
# fi

if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $GCC_SRC/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                          --with-gmp=$PREREQ_INSTALL --with-mpfr=$PREREQ_INSTALL --with-mpc=$PREREQ_INSTALL \
                          --with-ppl=$PREREQ_INSTALL --with-cloog=$PREREQ_INSTALL \
                          --enable-cloog-backend=isl --with-host-libstdcxx='-lstdc++ -lm -lgcc_eh' \
                          --enable-shared --enable-static --enable-threads=posix \
                          --disable-multilib \
                          --enable-languages=$GCC_LANGUAGES --enable-libgomp \
                          --enable-sjlj-exceptions --enable-fully-dynamic-string \
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
