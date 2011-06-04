#!/usr/bin/env bash
set -e

# platform information
export HOST=x86_64-linux-gnu
export TARGET=x86_64-linux-gnu
export BUILD=x86_64-linux-gnu
export EXESUFFIX=
export SHORT_NAME=linux64
export CRT_MULTILIB='--disable-lib64 --enable-lib32'

# Projects to be built, in the right order
export PROJECTS="gmp mpfr mpc
                 ppl cloog
                 binutils
                 gcc
                 cleanup"

# common build steps
. ./scripts/common.sh  
