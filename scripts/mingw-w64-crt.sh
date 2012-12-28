#!/usr/bin/env bash
set -e

if [ -f configure.marker ]
then
  echo "--> Already configured"
else
  echo "--> Configuring"
  sh $SRC_DIR/mingw-w64/mingw-w64-crt/configure --host=$TARGET --build=$BUILD --target=$TARGET \
                                                --prefix=$PREFIX/$TARGET \
                                                $CRT_CONFIG \
                                                --enable-wildcard \
                                                > $LOG_DIR/mingw-w64-crt_configure.log 2>&1 || exit 1
  echo "--> Configured"
fi
touch configure.marker

if [ -f build.marker ]
then
  echo "--> Already built"
else
  echo "--> Building"
  make $MAKE_OPTS > $LOG_DIR/mingw-w64-crt_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
  echo "--> Already installed"
else
  echo "--> Installing"
  make $MAKE_OPTS install > $LOG_DIR/mingw-w64-crt_install.log 2>&1 || exit 1
fi
touch install.marker
