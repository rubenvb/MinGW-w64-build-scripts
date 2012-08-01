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

# native compiler options
if [ "$HOST" == "i686-w64-mingw32" ]
then
  export HOST_LDFLAGS="-Wl,--large-address-aware"
fi

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

#cleanup
echo "-> Cleanup"
cd $PREFIX
echo "--> Removing libtool files"
find . -name \*.la -exec rm -f {} \;
echo "--> Stripping executables"
find . -name \*.exe -exec $HOST-strip {} \;

#zipping
BIN_FILE_CLANG=$PACKAGE_DIR/$HOST/$TARGET-clang-${CLANG_VERSION}${MY_REVISION}-win32_rubenvb.7z

echo "---> Clang addon package"
cd $BUILD_DIR
$BIN_COMPRESS $BIN_FILE_CLANG $SHORT_NAME > $LOG_DIR/zipping.log
  