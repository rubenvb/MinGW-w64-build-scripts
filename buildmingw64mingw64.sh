#!/usr/bin/env bash
set -e

# platform information
export HOST_ARCH=x86_64
export HOST_VENDOR=w64
export HOST_OS=mingw32
export HOST="$HOST_ARCH-$HOST_VENDOR-$HOST_OS"

export TARGET_ARCH=x86_64
export TARGET_VENDOR=w64
export TARGET_OS=mingw32
export TARGET="$TARGET_ARCH-$TARGET_VENDOR-$TARGET_OS"
export CRT_CONFIG="--disable-lib32 --enable-lib64"

export SHORT_NAME=mingw64
export LONG_NAME=mingw64mingw64
export GDB_PYTHON_WIN64_WORKAROUND='-DMS_WIN64'

# call main build script
. ./scripts/buildfromcross.sh
