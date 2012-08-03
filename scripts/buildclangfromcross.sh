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

# build LLVM-Clang
echo "-> Building LLVM/Clang"
cd $BUILD_DIR/LLVM-Clang
. $SCRIPTS/LLVM-Clang.sh || exit 1

# copy licenses
echo "-> Copying LLVM/Clang licenses"
mkdir -p $PREFIX/licenses
cd $PREFIX/licenses
mkdir -p LLVM
cp $SRC_DIR/LLVM/CREDITS.TXT LLVM/CREDITS.TXT
cp $SRC_DIR/LLVM/LICENSE.TXT LLVM/LICENSE.TXT
mkdir -p clang
cp $SRC_DIR/LLVM/tools/clang/LICENSE.TXT clang/LICENSE.TXT

# copy environment setup
cp $TOP_DIR/envsetup/clang32env.cmd $PREFIX/

# cleanup
echo "-> Cleanup"
cd $PREFIX
echo "--> Removing libtool files"
find . -name \*.la -exec rm -f {} \;
echo "--> Stripping executables"
find . -name \*.exe -exec $HOST-strip {} \;

# zipping
echo "-> Packaging Clang addon package"
SRC_COMPRESS="tar -J -hcf"
BIN_COMPRESS="7za -l -bd -mx9 a"
BIN_FILE_CLANG=$PACKAGE_DIR/$HOST/$TARGET-clang-${RUBENVB_CLANG_VERSION}-win32_rubenvb.7z
CLANG_SRC_FILE=$PACKAGE_DIR/clang-${RUBENVB_CLANG_VERSION}_rubenvb.tar.xz

cd $BUILD_DIR
$BIN_COMPRESS $BIN_FILE_CLANG $SHORT_NAME > $LOG_DIR/zipping.log
cd $TOP_DIR
$SRC_COMPRESS $CLANG_SRC_FILE --exclude='*.git*' --exclude='*.svn*' build*clang32.sh scripts/buildclangfromcross.sh src/LLVM
