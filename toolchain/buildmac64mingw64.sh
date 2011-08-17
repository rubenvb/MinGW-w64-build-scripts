#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-apple-darwin9
export TARGET=i686-w64-mingw32
export BUILD=x86_64-linux-gnu
export EXESUFFIX=
export SHORT_NAME=mingw64
export LONG_NAME=mac64mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'

# Projects to be built, in the right order
export PROJECTS="libiconv expat
                 mpir mpfr mpc ppl cloog
                 mingw-w64-headers
                 binutils
                 gcc-c
                 mingw-w64-crt
                 libgcc
                 winpthreads
                 gcc
                 cleanup
                 zipping"

# common build steps
. ./scripts/common.sh  
