#!/usr/bin/env bash
set -e

#platforms
export HOST=i686-w64-mingw32
export TARGET=i686-w64-mingw32
export BUILD=x86_64-gnu-linux
export EXESUFFIX=".exe"
export SHORT_NAME=mingw32
export CRT_MULTILIB='--disable-lib64 --enable-lib32'

# Projects to be built, in the right order
PROJECTS="expat libiconv
          gmp mpfr mpc ppl cloog
          mingw-w64-headers
          pthreads
          binutils
          gcc-c
          mingw-w64-crt
          gcc
          gdb
          make
          cleanup
          zipping"

# native compiler options
export GNU_WIN32_OPTIONS='--disable-win32-registry --disable-rpath --disable-werror'

# common build steps
. ./scripts/common.sh

