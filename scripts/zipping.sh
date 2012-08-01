#!/usr/bin/env bash
set -e

SRC_FILE=$PACKAGE_DIR/gcc-${GCC_VERSION}${MY_REVISION}_rubenvb.tar.xz

case $HOST in
  "i686-w64-mingw32")
    PLATFORM_SUFFIX="win32"
    ;;
  "x86_64-w64-mingw32")
    PLATFORM_SUFFIX="win64"
    ;;
  "x86_64-linux-gnu")
    PLATFORM_SUFFIX="linux64"
    ;;
  "i686-linux-gnu")
    PLATFORM_SUFFIX="linux32"
    ;;
  "x86_64-apple-darwin10")
    PLATFORM_SUFFIX="mac64"
    ;;
  "i686-apple-darwin10")
    PLATFORM_SUFFIX="mac32"
    ;;
  "i686-pc-cygwin")
    PLATFORM_SUFFIX="cygwin"
    ;;
  *)
    echo "-> unknown host set: $HOST"
    ;;
esac

if [ "$HOST_OS" == "mingw32" ]
then
  BIN_COMPRESS="7za -l -bd -mx9 a"
  BIN_FILE=$PACKAGE_DIR/$HOST/$TARGET-gcc-${GCC_VERSION}${MY_REVISION}-${PLATFORM_SUFFIX}_rubenvb.7z
  CLANG_SRC_FILE=$PACKAGE_DIR/clang-${CLANG_VERSION}_rubenvb.tar.xz
else
  BIN_COMPRESS="tar -J -cf"
  BIN_FILE=$PACKAGE_DIR/$HOST/$TARGET-gcc-${GCC_VERSION}${MY_REVISION}-${PLATFORM_SUFFIX}_rubenvb.tar.xz
fi

if [ -f $BIN_FILE ]
then
  echo "--> Binary file already exists"
else
  echo "--> Zipping binaries"
  cd $PREFIX/..
  # Base package
  echo "---> Base package"
  $BIN_COMPRESS $BIN_FILE $SHORT_NAME > $LOG_DIR/zipping.log
fi

if [ -f $SRC_FILE ]
then
  echo "--> Source file already exists"
else
  echo "--> Zipping sources"
  cd $TOP_DIR
  TAR_EXCLUDES="--exclude='*.git' --exclude='*.svn'"
  if [ "$SHORT_NAME" != "mingw32-dw2" ]
  then
    tar -J -h cf $CLANG_SRC_FILE buildclang32.sh scripts/buildclangfromcross.sh src/LLVM
  fi
  tar -J -h -cf $SRC_FILE $TAR_EXCLUDES --exclude='src/LLVM/' --exclude='buildclang32.sh' --exclude='scripts/buildclangfromcross.sh' src scripts patches *.sh
fi

cd $TOP_DIR

