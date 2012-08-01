#!/usr/bin/env bash
set -e

if [ -f configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/make/configure --host=$HOST --build=$BUILD --prefix=$PREFIX \
                               --enable-job-server \
                               --enable-case-insensitive-file-system --program-prefix='mingw32-' \
                               CFLAGS="$HOST_CFLAGS" LDFLAGS="$HOST_LDFLAGS" \
                               > $LOG_DIR/make_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch configure.marker

if [ -f build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    /usr/bin/make $MAKE_OPTS > $LOG_DIR/make_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    /usr/bin/make $MAKE_OPTS install > $LOG_DIR/make_install.log 2>&1 || exit 1
fi
touch install.marker
