#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-apple-darwin10
export TARGET=i686-w64-mingw32
export BUILD=x86_64-redhat-linux
export EXESUFFIX=
export SHORT_NAME=mingw64
export LONG_NAME=mac64mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'

# call main build script
. ./scripts/buildnative.sh
