#!/usr/bin/env bash
set -e

# platform information
export HOST_ARCH=i686
export HOST_VENDOR=w64
export HOST_OS=mingw32
export HOST=$HOST_ARCH-$HOST_VENDOR-$HOST_OS
export TARGET=x86_64-w64-mingw32
export SHORT_NAME=mingw32
export LONG_NAME=mingw32mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND=

# call main build script
. ./scripts/buildfromcross.sh
