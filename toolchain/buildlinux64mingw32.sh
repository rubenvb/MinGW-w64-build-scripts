#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-linux-gnu
export TARGET=i686-w64-mingw32
export BUILD=x86_64-linux-gnu
export EXESUFFIX=
export SHORT_NAME=mingw32
export LONG_NAME=linux64mingw32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'


# call main build script
. ./scripts/buildcross.sh
