#!/usr/bin/env bash
set -e

# platform information
export HOST_ARCH=i686
export HOST_VENDOR=w64
export HOST_OS=mingw32
export HOST=$HOST_ARCH-$HOST_VENDOR-$HOST_OS

export TARGET_ARCH=i686
export TARGET_VENDOR=w64
export TARGET_OS=mingw32

export TARGET=$TARGET_ARCH-$TARGET_VENDOR-$TARGET_OS

export SHORT_NAME=mingw32-dw2
export LONG_NAME=clang32mingw32

# common settings
echo "Executing preliminary setup"
export BUILD_CROSS_FROM_NATIVE="true"
# build settings
. ./scripts/settings.sh || exit 1
# version info
echo "-> Loading version info"
. ./scripts/versions.sh || exit 1
# set up and create directories
echo "-> Setting up directories"
. ./scripts/directories.sh || exit 1

# native compiler options
export MAKE_AR="AR=$HOST-ar" # necessary for libiconv+x86_64-apple-darwin10
if [ "$HOST" == "i686-w64-mingw32" ] || [ "$HOST" == "i686-pc-cygwin" ]
then
    export HOST_LDFLAGS="-Wl,--large-address-aware"
fi

# build LLVM/Clang
. ./scripts/LLVM-Clang.sh
