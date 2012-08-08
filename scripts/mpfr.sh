#!/usr/bin/env bash
set -e

if [ -f configure.marker ]
then
  echo "--> Already configured"
else
  echo "--> Configuring"
  sh $SRC_DIR/mpfr/configure --host=$HOST --build=$BUILD --prefix=$PREREQ_INSTALL \
                             --disable-shared --enable-static \
                             --with-gmp=$PREREQ_INSTALL \
                             CC="$HOST_CC" CFLAGS="$HOST_CFLAGS" LDFLAGS="$HOST_LDFLAGS" \
                             > $LOG_DIR/mpfr_configure.log 2>&1 || exit 1
  echo "--> Configured"
fi
touch configure.marker

if [ -f build.marker ]
then
  echo "--> Already built"
else
  echo "--> Building"
  make $MAKE_OPTS > $LOG_DIR/mpfr_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
  echo "--> Already installed"
else
  echo "--> Installing"
  make $MAKE_OPTS install > $LOG_DIR/mpfr_install.log 2>&1 || exit 1
fi
touch install.marker
