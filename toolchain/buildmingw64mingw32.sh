#!/usr/bin/env bash
set -e

#platforms
export HOST=x86_64-w64-mingw32
export TARGET=i686-w64-mingw32
export BUILD=x86_64-redhat-linux
export EXESUFFIX=".exe"
export SHORT_NAME=mingw64
export LONG_NAME=mingw64mingw32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND='-DMS_WIN64'

# call main build script
. ./scripts/buildnative.sh
