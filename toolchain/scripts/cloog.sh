#!/usr/bin/env bash
set -e

if [ -f cloog_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/cloog-$CLOOG_VERSION/configure --host=$HOST --build=$BUILD --prefix=$GCC_LIBS \
                                               $SHARED --with-gmp-prefix=$GCC_LIBS \
                                               CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                               > $LOG_DIR/cloog_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch cloog_configure.marker

if [ -f cloog_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/cloog_build.log 2>&1 || exit 1
fi
touch cloog_build.marker
if [ -f cloog_install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install > $LOG_DIR/cloog_install.log 2>&1 || exit 1
fi
touch cloog_install.marker
