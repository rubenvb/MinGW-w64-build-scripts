#!/usr/bin/env bash
set -e

if [ -f mpfr_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/mpfr-$MPFR_VERSION/configure --host=$HOST --build=$BUILD --prefix=$GCC_LIBS \
                                             $SHARED --with-gmp=$GCC_LIBS \
                                             CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                             > $LOG_DIR/mpfr_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch mpfr_configure.marker

if [ -f mpfr_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/mpfr_build.log 2>&1 || exit 1
fi
touch mpfr_build.marker
if [ -f mpfr_install.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
	make $MAKE_OPTS install > $LOG_DIR/mpfr_install.log 2>&1 || exit 1
fi
touch mpfr_install.marker
