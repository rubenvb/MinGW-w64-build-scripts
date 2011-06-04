#!/usr/bin/env bash
set -e

if [ -f gmp_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh ../../src/gmp-$GMP_VERSION/configure --host=$HOST --build=$BUILD --prefix=$GCC_LIBS \
                                            $SHARED --disable-static --enable-cxx \
                                            CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                            > $LOG_DIR/gmp_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch gmp_configure.marker

if [ -f gmp_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/gmp_build.log 2>&1 || exit 1
fi
touch gmp_build.marker
if [ -f gmp_install.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
	make $MAKE_OPTS install > $LOG_DIR/gmp_install.log 2>&1  || exit 1
fi
touch gmp_install.marker
