#!/usr/bin/env bash
set -e

# platform information
export HOST_ARCH=i686
export HOST_VENDOR=apple
export HOST_OS=darwin10
export HOST=$HOST_ARCH-$HOST_VENDOR-$HOST_OS
export TARGET=x86_64-w64-mingw32
export SHORT_NAME=mingw64
export LONG_NAME=mac32mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND=

export CC='i686-apple-darwin10-gcc'
export CXX='i686-apple-darwin10-g++'

# call main build script
. ./scripts/buildfromcross.sh
