#!/usr/bin/env bash
set -e

if [ "$SHORT_NAME$" == "mingw32-dw2" ]
then
  GCC_EXCEPTIONS="--enable-dw2-exceptions --disable-sjlj-exceptions"
else
  GCC_EXCEPTIONS="--disable-dw2-exceptions --enable-sjlj-exceptions"
fi

if [ -f configure.marker ]
then
  echo "--> Already configured"
else
  echo "--> Configuring"
  sh $SRC_DIR/gcc/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                            --with-gmp=$PREREQ_INSTALL --with-mpfr=$PREREQ_INSTALL --with-mpc=$PREREQ_INSTALL \
                            --with-ppl=$PREREQ_INSTALL --with-cloog=$PREREQ_INSTALL \
                            --enable-cloog-backend=isl --with-host-libstdcxx='-static -lstdc++ -lm' \
                            --enable-shared --enable-static --enable-threads=win32 \
                            --enable-plugins --disable-multilib \
                            --enable-languages=$GCC_LANGUAGES --enable-libgomp --enable-libstdcxx-debug \
                            $GCC_EXCEPTIONS --enable-fully-dynamic-string \
                            --disable-nls --disable-werror --enable-checking=release \
                            --with-gnu-as --with-gnu-ld \
                            $GNU_WIN32_OPTIONS \
                            CFLAGS="$HOST_CFLAGS" LDFLAGS="$HOST_LDFLAGS" \
                            > $LOG_DIR/gcc_configure.log 2>&1 || exit 1
  echo "--> Configured"
fi
touch configure.marker

if [ -f build-c.marker ]
then
  echo "--> Already built"
else
  echo "--> Building gcc"
  make $MAKE_OPTS all-gcc > $LOG_DIR/gcc-c_build.log 2>&1 || exit 1
fi
touch build-c.marker

if [ -f install-c.marker ]
then
  echo "--> Already installed"
else
  echo "--> Installing gcc"
  make $MAKE_OPTS install-gcc > $LOG_DIR/gcc-c_install.log 2>&1 || exit 1
fi
touch install-c.marker
