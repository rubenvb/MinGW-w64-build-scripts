#!/usr/bin/env bash
set -e

# get version info
. ./scripts/versions.sh

# make and enter source and downloads dir
TOP_DIR=`pwd`
SOURCE_DIR="$TOP_DIR/src"
DOWNLOADS_DIR="$TOP_DIR/downloads"
mkdir -p "$SOURCE_DIR" "$DOWNLOADS_DIR"
cd "$SOURCE_DIR"

# fixed version downloads
function update()
{
  NAME=$1
  VERSION=$2
  EXTENSION=$3
  URL=$4
  echo "-> $NAME, version $VERSION"
  if [ ! -d "$SOURCE_DIR/$NAME-$VERSION" ]
  then
    echo "--> Removing old versions"
    rm -rf "$SOURCE_DIR/$NAME-*"
    echo "--> Downloading version $VERSION"
    wget -v "$URL/$NAME-$VERSION$EXTENSION" -O "$DOWNLOADS_DIR/$NAME-$VERSION$EXTENSION" > /dev/null 2>&1 || exit 1
    echo "--> Extracting"
    tar -xf "$DOWNLOADS_DIR/$NAME-$VERSION$EXTENSION" || exit 1
  fi
  echo "--> Up to date"
}

update "libiconv" "$LIBICONV_VERSION" ".tar.gz"  "http://ftp.gnu.org/pub/gnu/libiconv" || exit 1
update "expat"    "$EXPAT_VERSION"    ".tar.gz"  "http://downloads.sourceforge.net/project/expat/expat/$EXPAT_VERSION" || exit 1
update "gmp"      "$GMP_VERSION"      ".tar.bz2" "ftp://ftp.gmplib.org/pub/gmp-$GMP_VERSION" || exit 1
update "mpfr"     "$MPFR_VERSION"     ".tar.xz"  "http://www.mpfr.org/mpfr-$MPFR_VERSION" || exit 1
update "mpc"      "$MPC_VERSION"      ".tar.gz"  "http://www.multiprecision.org/mpc/download" || exit 1
update "ppl"      "$PPL_VERSION"      ".tar.bz2" "ftp://ftp.cs.unipr.it/pub/ppl/releases/$PPL_VERSION" || exit 1
update "cloog"    "$CLOOG_VERSION"    ".tar.gz"  "http://www.bastoul.net/cloog/pages/download/count.php3?url=." || exit 1
update "make"     "$MAKE_VERSION"     ".tar.bz2" "http://ftp.gnu.org/gnu/make" || exit 1

echo "-> Removing temporary downloads"
rm -rf "$DOWNLOADS_DIR"

# Version control downloads
# release revisions
function gcc_svn_revision()
{
  case $1 in
  "4.5.1") echo "162774" ;;
  "4.5.2") echo "167946" ;;
  "4.5.3") echo "173114" ;;
  "4.6.0") echo "171513" ;;
  "4.6.1") echo "175473" ;;
  "4.6.2") echo "184738" ;;
  "4.6.3") echo "184738" ;;
  "4.7.0") echo "185675" ;;
  esac
}
function vc()
{
  local NAME=$1
  local VC=$2
  local URL=$3
  echo "-> $NAME, from version control"
  if [ ! -d "$SOURCE_DIR/$NAME" ]
  then
    mkdir "$SOURCE_DIR/$NAME" || exit 1
    cd "$SOURCE_DIR/$NAME"
    echo "--> Fetching $NAME sources from $VC"
    case $VC in
    "svn")
      svn co "$URL" . > /dev/null 2>&1 || exit 1
      ;;
    "git")
      git clone --depth=1 "$URL" . > /dev/null 2>&1 || exit 1
      if [ "$NAME" = "gcc" ]
      then
        . "$TOP_DIR/scripts/gcc_tag_releases.sh"
      fi
      ;;
    esac
  else
    cd $SOURCE_DIR/$NAME
    echo "--> Updating from $VC"
    case $VC in
    "svn")
      svn up > /dev/null 2>&1 || exit 1
      ;;
    "git")
      git pull > /dev/null 2>&1 || exit 1
      ;;
    esac
  fi
}

#always trunk
vc "binutils"         "git" "git://sourceware.org/git/binutils.git" || exit 1
vc "gdb"              "git" "git://sourceware.org/git/gdb.git" || exit 1

vc "mingw-w64"        "svn" "https://mingw-w64.svn.sourceforge.net/svnroot/mingw-w64" || exit 1
vc "gcc"              "git" "git://gcc.gnu.org/git/gcc.git" || exit 1
vc "LLVM"             "svn" "http://llvm.org/svn/llvm-project/llvm/trunk" || exit 1
vc "LLVM/tools/clang" "svn" "http://llvm.org/svn/llvm-project/cfe/trunk" || exit 1

# patches
#todo

cd $TOP_DIR
