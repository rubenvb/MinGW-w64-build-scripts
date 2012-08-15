#!/usr/bin/env bash
set -e

# platform information
export HOST_ARCH=i686
export HOST_VENDOR=apple
export HOST_OS=darwin11
export HOST="$HOST_ARCH-$HOST_VENDOR-$HOST_OS"

export TARGET_ARCH=i686
export TARGET_VENDOR=w64
export TARGET_OS=mingw32
export TARGET=$TARGET_ARCH-$TARGET_VENDOR-$TARGET_OS
export CRT_CONFIG="--enable-lib32 --disable-lib64"

export SHORT_NAME=mingw32
export LONG_NAME=mac32mingw32

# call main build script
. ./scripts/buildfromcross.sh
