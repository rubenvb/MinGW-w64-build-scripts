#!/usr/bin/env bash
set -e

#platforms
export HOST=i686-w64-mingw32
export TARGET=x86_64-w64-mingw32
export BUILD=x86_64-redhat-linux
export EXESUFFIX=".exe"
export SHORT_NAME=mingw32
export LONG_NAME=mingw32mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'

# call main build script
. ./scripts/buildfromcross.sh
