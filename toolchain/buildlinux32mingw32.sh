#!/usr/bin/env bash
set -e

# platform information
export HOST=i686-linux-gnu
export TARGET=i686-w64-mingw32
export BUILD=x86_64-linux-gnu
export EXESUFFIX=
export SHORT_NAME=mingw32
export LONG_NAME=linux32mingw32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'

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
