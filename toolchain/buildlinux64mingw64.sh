#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-linux-gnu
export TARGET=x86_64-w64-mingw32
export SHORT_NAME=mingw64
export LONG_NAME=linux64mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'

# call main build script
. ./scripts/buildfromnative.sh
