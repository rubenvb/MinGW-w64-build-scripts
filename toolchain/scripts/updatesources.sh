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
    wget -v "$URL/$NAME-$VERSION$EXTENSION" -O "$DOWNLOADS_DIR/$NAME-$VERSION$EXTENSION" > /dev/null 2>&1 || exit 1
    echo "--> Extracting"
    tar -xf "$DOWNLOADS_DIR/$NAME-$VERSION$EXTENSION" || exit 1
  fi
  echo "--> Up to date"
}

update "libiconv" $LIBICONV_VERSION ".tar.gz"  "http://ftp.gnu.org/pub/gnu/libiconv" || exit 1
update "expat"    $EXPAT_VERSION    ".tar.gz"  "http://downloads.sourceforge.net/project/expat/expat/$EXPAT_VERSION" || exit 1
update "gmp"      $GMP_VERSION      ".tar.bz2" "ftp://ftp.gmplib.org/pub/gmp-$GMP_VERSION" || exit 1
update "mpfr"     $MPFR_VERSION     ".tar.xz"  "http://www.mpfr.org/mpfr-$MPFR_VERSION" || exit 1
update "mpc"      $MPC_VERSION      ".tar.gz"  "http://www.multiprecision.org/mpc/download" || exit 1
update "ppl"      $PPL_VERSION      ".tar.bz2" "ftp://ftp.cs.unipr.it/pub/ppl/releases/$PPL_VERSION" || exit 1
update "cloog"    $CLOOG_VERSION    ".tar.gz"  "http://www.bastoul.net/cloog/pages/download/count.php3?url=." || exit 1
update "make"     $MAKE_VERSION     ".tar.bz2" "http://ftp.gnu.org/gnu/make" || exit 1

echo "-> Removing temporary downloads"
rm -rf $DOWNLOADS_DIR

# Version control downloads
#
# Examples:
#   vc "LLVM" "svn" "http://llvm.org/svn/llvm-project/llvm/trunk" || exit 1
#   vc "LLVM" "svn" "http://llvm.org/svn/llvm-project/llvm" "trunk" || exit 1
#   vc "LLVM" "svn" "http://llvm.org/svn/llvm-project/llvm" "branches/fake-branch || exit 1
#   vc "gcc"  "git" "git://gcc.gnu.org/git/gcc.git" "fake-branch" || exit 1
#   vc "fake" "git" "git://example.com/git/fake.git" "someone/mods" || exit 1
function vc()
{
  NAME=$1
  VC=$2
  URL=$3
  BRANCH=$4
  echo "-> $NAME, from version control"
  if [ ! -d $SOURCE_DIR/$NAME ]
  then
    mkdir $SOURCE_DIR/$NAME || exit 1
    cd $SOURCE_DIR/$NAME
    echo "--> Fetching $NAME sources from $VC"
    case $VC in
    "svn")
      if [ ! -z $BRANCH ]
      then
        svn co "$URL/$BRANCH" . > /dev/null 2>&1 || exit 1
      else
        svn co $URL . > /dev/null 2>&1 || exit 1
      fi
      ;;
    "git")
      if [ ! -z $BRANCH ]
      then
        git clone --depth=1 -b $BRANCH $URL . > /dev/null 2>&1 || exit 1
      else
        git clone --depth=1 $URL . > /dev/null 2>&1 || exit 1
      fi
      ;;
    esac
  else
    cd $SOURCE_DIR/$NAME
    echo "--> Updating from $VC"
    case $VC in
    "svn")
      # XXX assumes repo is already on correct branch. Always `svn switch`?
      svn up > /dev/null 2>&1 || exit 1
      ;;
    "git")
      if [ ! -z $BRANCH ]
      then
        # XXX --force throws away any local changes in repo
        git checkout --force $BRANCH
      fi
      git pull > /dev/null 2>&1 || exit 1
      ;;
    esac
  fi
}

vc "binutils"         "git" "git://sourceware.org/git/binutils.git" || exit 1
vc "mingw-w64"        "svn" "https://mingw-w64.svn.sourceforge.net/svnroot/mingw-w64" || exit 1
vc "gcc"              "git" "git://gcc.gnu.org/git/gcc.git" || exit 1
vc "gdb"              "git" "git://sourceware.org/git/gdb.git" || exit 1
vc "LLVM"             "svn" "http://llvm.org/svn/llvm-project/llvm/trunk" || exit 1
vc "LLVM/tools/clang" "svn" "http://llvm.org/svn/llvm-project/cfe/trunk" || exit 1

# patches
#todo

cd $TOP_DIR
