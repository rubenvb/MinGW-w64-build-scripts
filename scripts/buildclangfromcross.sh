#!/usr/bin/env bash
set -e

# common settings
echo "Executing preliminary setup"
# build settings
. ./scripts/settings.sh || exit 1
# version info
echo "-> Loading version info"
. ./scripts/versions.sh || exit 1
# set up and create directories
echo "-> Setting up directories"
. ./scripts/directories.sh || exit 1

# build directory
mkdir -p $BUILD_DIR/LLVM-Clang
mkdir -p $BUILD_DIR/licenses
mkdir -p $BUILD_DIR/cleanup

# build LLVM-Clang
echo "-> Building LLVM/Clang"
cd $BUILD_DIR/LLVM-Clang
. $SCRIPTS/LLVM-Clang.sh || exit 1

# copy licenses
echo "-> Copying LLVM/Clang licenses"
cd $BUILD_DIR/licenses
if [ -f licenses.marker ]
then
  echo "--> Licenses already installed."
else
  echo "--> Installing LLVM/Clang licenses."
  mkdir -p LLVM
  cp $SRC_DIR/LLVM/CREDITS.TXT LLVM/CREDITS.TXT
  cp $SRC_DIR/LLVM/LICENSE.TXT LLVM/LICENSE.TXT

  mkdir -p clang
  cp $SRC_DIR/LLVM/tools/clang/LICENSE.TXT clang/LICENSE.TXT

  mkdir -p $PREFIX/licenses
  cp -r . $PREFIX/licenses

  echo "--> Done!"
fi
touch licenses.marker

# copy environment setup
if [ "$TARGET_ARCH" = "i686" ]
then
  cp $TOP_DIR/envsetup/clang32env.cmd $PREFIX/
else
  cp $TOP_DIR/envsetup/clang64env.cmd $PREFIX/
fi
# cleanup
echo "-> Cleanup"
cd $BUILD_DIR/cleanup
if [ -f cleanup.marker ]
then
  echo "Already cleaned up."
else
  cd $PREFIX
  echo "--> Removing libtool files"
  find . -name \*.la -exec rm -f {} \;
  echo "--> Stripping executables"
  find . -name \*.exe -exec $HOST-strip {} \;
  cd $BUILD_DIR/cleanup
  echo "--> Done!"
fi
touch cleanup.marker

# zipping
echo "-> Packaging Clang addon package"
export XZ_OPT="-9"
SRC_COMPRESS="tar -Jhcf"
BIN_COMPRESS="7za -l -bd -mx9 a"
if [ "$HOST_ARCH" == "i686" ]
then
  BIN_FILE_CLANG=$PACKAGE_DIR/$HOST/$TARGET-clang-${RUBENVB_CLANG_VERSION}-win32_rubenvb.7z
else
  BIN_FILE_CLANG=$PACKAGE_DIR/$HOST/$TARGET-clang-${RUBENVB_CLANG_VERSION}-win64_rubenvb.7z
fi
CLANG_SRC_FILE=$PACKAGE_DIR/clang-${RUBENVB_CLANG_VERSION}_rubenvb.tar.xz

cd $BUILD_DIR
$BIN_COMPRESS $BIN_FILE_CLANG $SHORT_NAME > $LOG_DIR/zipping.log
cd $TOP_DIR
$SRC_COMPRESS $CLANG_SRC_FILE --exclude='*.git*' --exclude='*.svn*' build*clang??.sh scripts/buildclangfromcross.sh scripts/LLVM-Clang.sh src/LLVM
