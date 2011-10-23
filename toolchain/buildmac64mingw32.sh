#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-apple-darwin10
export TARGET=i686-w64-mingw32
export SHORT_NAME=mingw32
export LONG_NAME=mac64mingw32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND=

# call main build script
. ./scripts/buildfromcross.sh
