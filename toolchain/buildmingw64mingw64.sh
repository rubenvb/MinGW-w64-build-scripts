#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-w64-mingw32
export TARGET=x86_64-w64-mingw32
export BUILD=x86_64-redhat-linux
export EXESUFFIX=".exe"
export SHORT_NAME=mingw64
export LONG_NAME=mingw64mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND='-DMS_WIN64'

# call main build script
. ./scripts/buildfromcross.sh
