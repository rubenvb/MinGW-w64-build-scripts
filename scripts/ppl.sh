#!/usr/bin/env bash
set -e

if [ -f $MARKER_DIR/ppl_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/ppl-$PPL_VERSION/configure --host=$HOST --build=$BUILD --prefix=$GCC_LIBS \
                                           $SHARED --with-gmp-prefix=$GCC_LIBS  \
                                           CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                           > $LOG_DIR/ppl_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch $MARKER_DIR/ppl_configure.marker

if [ -f $MARKER_DIR/ppl_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/ppl_build.log 2>&1 || exit 1
fi
touch $MARKER_DIR/ppl_build.marker
if [ -f $MARKER_DIR/ppl_install.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
	make $MAKE_OPTS install > $LOG_DIR/ppl_install.log 2>&1 || exit 1
fi
touch $MARKER_DIR/ppl_install.marker
