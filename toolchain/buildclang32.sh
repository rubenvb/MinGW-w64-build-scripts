#!/usr/bin/env bash
set -e

# platform information
export HOST_ARCH=i686
export HOST_VENDOR=w64
export HOST_OS=mingw32
export HOST=$HOST_ARCH-$HOST_VENDOR-$HOST_OS
export TARGET=i686-w64-mingw32
export SHORT_NAME=mingw32
export LONG_NAME=clang32mingw32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND=

# Build GCC
. ./scripts/buildfromcross.sh
# Build LLVM/Clang
. ./scripts/buildclang.sh
