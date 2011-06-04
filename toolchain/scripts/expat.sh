#!/usr/bin/env bash
set -e

if [ -f expat_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/expat-$EXPAT_VERSION/configure --host=$HOST --build=$BUILD --prefix=$GCC_LIBS \
                                               $SHARED \
                                               CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                               > $LOG_DIR/expat_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch expat_configure.marker

if [ -f expat_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/expat_build.log 2>&1 || exit 1
fi
touch expat_build.marker
if [ -f expat_install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
	make $MAKE_OPTS install > $LOG_DIR/expat_install.log 2>&1 || exit 1
fi
touch expat_install.marker
