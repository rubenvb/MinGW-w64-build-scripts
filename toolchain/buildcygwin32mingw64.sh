#!/usr/bin/env bash
set -e

# platform information
export HOST=i686-pc-cygwin
export TARGET=x86_64-w64-mingw32
export EXESUFFIX=
export SHORT_NAME=mingw64
export LONG_NAME=cygwin32mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'

# call main build script
. ./scripts/buildfromcross.sh
