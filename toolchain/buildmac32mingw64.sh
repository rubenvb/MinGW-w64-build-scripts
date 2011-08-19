#!/usr/bin/env bash
set -e

# platform information
export HOST=i686-apple-darwin10
export TARGET=x86_64-w64-mingw32
export BUILD=x86_64-redhat-linux
export EXESUFFIX=
export SHORT_NAME=mingw64
export LONG_NAME=mac32mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'

# Projects to be built, in the right order
export PROJECTS="libiconv expat
                 gmp mpfr mpc ppl cloog
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
