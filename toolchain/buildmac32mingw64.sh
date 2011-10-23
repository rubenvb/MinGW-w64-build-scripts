#!/usr/bin/env bash
set -e

# platform information
export HOST=i686-apple-darwin10
export TARGET=x86_64-w64-mingw32
export SHORT_NAME=mingw64
export LONG_NAME=mac32mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND=

# call main build script
. ./scripts/buildfromcross.sh
