#!/usr/bin/env bash
set -e

# get version info
. ./scripts/versions.sh

# make and enter source and downloads dir
TOP_DIR=`pwd`
SOURCE_DIR=$TOP_DIR/src
DOWNLOADS_DIR=$TOP_DIR/downloads
mkdir -p $SOURCE_DIR $DOWNLOADS_DIR
cd $SOURCE_DIR

# fixed version downloads
function update()
{
  NAME=$1
  VERSION=$2
  EXTENSION=$3
  URL=$4
  echo "-> $NAME, version $VERSION"
  if [ ! -d $SOURCE_DIR/$NAME-$VERSION ]
  then
    echo "--> Removing old versions"
    rm -rf $SOURCE_DIR/$NAME-*
    echo "--> Downloading version $VERSION"
    echo "wget \"$URL/$NAME-$VERSION$EXTENSION\" -O \"$DOWNLOADS_DIR/$NAME-$VERSION$EXTENSION\""
    wget -v "$URL/$NAME-$VERSION$EXTENSION" -O "$DOWNLOADS_DIR/$NAME-$VERSION$EXTENSION" > /dev/null 2>&1 || exit 1
    echo "--> Extracting"
    tar -xf "$DOWNLOADS_DIR/$NAME-$VERSION$EXTENSION" || exit 1
  fi
  echo "--> Up to date"
}

update libiconv $LIBICONV_VERSION ".tar.gz" "http://ftp.gnu.org/pub/gnu/libiconv" || exit 1
update expat $EXPAT_VERSION ".tar.gz" "http://downloads.sourceforge.net/project/expat/expat/$EXPAT_VERSION" || exit 1
update gmp $GMP_VERSION ".tar.bz2" "ftp://ftp.gmplib.org/pub/gmp-$GMP_VERSION" || exit 1
update mpfr $MPFR_VERSION ".tar.xz" "http://www.mpfr.org/mpfr-$MPFR_VERSION" || exit 1
update mpc $MPC_VERSION ".tar.gz" "http://www.multiprecision.org/mpc/download" || exit 1
update ppl $PPL_VERSION ".tar.bz2" "ftp://ftp.cs.unipr.it/pub/ppl/releases/$PPL_VERSION" || exit 1
update cloog $CLOOG_VERSION ".tar.gz" "http://www.bastoul.net/cloog/pages/download/count.php3?url=." || exit 1
update make $MAKE_VERSION ".tar.bz2" "http://ftp.gnu.org/gnu/make" || exit 1

rm -rf $DOWNLOADS_DIR

# Version control downloads
#TODO

# patches
#TODO

cd $TOP_DIR
