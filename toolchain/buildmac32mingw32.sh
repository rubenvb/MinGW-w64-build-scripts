#!/usr/bin/env bash
set -e

# platform information
export HOST=i686-apple-darwin10
export TARGET=i686-w64-mingw32
export EXESUFFIX=
export SHORT_NAME=mingw32
export LONG_NAME=mac32mingw32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'

# call main build script
. ./scripts/buildfromcross.sh
