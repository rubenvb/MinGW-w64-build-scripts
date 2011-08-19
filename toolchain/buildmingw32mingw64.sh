#!/usr/bin/env bash
set -e

#platforms
export HOST=i686-w64-mingw32
export TARGET=x86_64-w64-mingw32
export BUILD=x86_64-redhat-linux
export EXESUFFIX=".exe"
export SHORT_NAME=mingw32
export LONG_NAME=mingw32mingw64
export CRT_MULTILIB='--enable-lib64 --disable-lib32'

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

# common build steps
. ./scripts/common.sh

