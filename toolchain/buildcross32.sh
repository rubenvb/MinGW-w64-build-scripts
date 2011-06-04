#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-linux-gnu
export TARGET=i686-w64-mingw32
export BUILD=x86_64-linux-gnu
export EXESUFFIX=
export SHORT_NAME=cross32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'

# Projects to be built, in the right order
export PROJECTS="mingw-w64-headers
                 pthreads
                 binutils
                 gcc-c
                 mingw-w64-crt
                 gcc
                 cleanup"

# common build steps
. ./scripts/common.sh  
