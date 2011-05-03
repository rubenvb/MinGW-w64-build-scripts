#!/usr/bin/env bash
set -e

if [ -f $MARKER_DIR/libiconv_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/libiconv-$LIBICONV_VERSION/configure --host=$HOST --build=$BUILD --prefix=$GCC_LIBS \
                                                     $SHARED \
                                                     CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                                     > $LOG_DIR/libiconv_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch $MARKER_DIR/libiconv_configure.marker

if [ -f $MARKER_DIR/libiconv_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/libiconv_build.log 2>&1 || exit 1
fi
touch $MARKER_DIR/libiconv_build.marker
if [ -f $MARKER_DIR/libiconv_install.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
    make $MAKE_OPTS install > $LOG_DIR/libiconv_install.log 2>&1 || exit 1
fi
touch $MARKER_DIR/libiconv_install.marker
