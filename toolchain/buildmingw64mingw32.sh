#!/usr/bin/env bash
set -e

#platforms
export HOST=x86_64-w64-mingw32
export TARGET=i686-w64-mingw32
export BUILD=x86_64-gnu-linux
export EXESUFFIX=".exe"
export SHORT_NAME=mingw64
export LONG_NAME=mingw64mingw64
export CRT_MULTILIB='--disable-lib64 --enable-lib32'
export GDB_PYTHON_WIN64_WORKAROUND='-DMS_WIN64'

# Projects to be built, in the right order
PROJECTS="expat libiconv
          gmp mpfr mpc ppl cloog
          mingw-w64-headers
          binutils
          mingw-w64-crt
          winpthreads
          gcc
          python
          gdb
          make
          llvm-clang
          cleanup
          zipping"

# native compiler options
export GNU_WIN32_OPTIONS='--disable-win32-registry --disable-rpath --disable-werror'

# add cross toolchains to PATH
. ./crosstoolchainpaths.sh

# common options
. ./scripts/common.sh
