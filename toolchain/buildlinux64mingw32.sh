#!/usr/bin/env bash
set -e

# platform information
export HOST_ARCH=x86_64
export HOST_VENDOR=linux
export HOST_OS=gnu
export HOST=$HOST_ARCH-$HOST_VENDOR-$HOST_OS
export HOST=x86_64-linux-gnu
export TARGET=i686-w64-mingw32
export SHORT_NAME=mingw32
export LONG_NAME=linux64mingw32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND=

# call main build script
. ./scripts/buildcrossfromnative.sh
