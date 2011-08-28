#!/usr/bin/env bash
set -e

# common settings
echo "Executing preliminary common steps"
export BUILD_CROSS_FROM_NATIVE="true"
. ./scripts/common.sh || exit 1

# Projects to be built, in the right order
PREGCC_STEPS="mingw-w64-headers
              binutils"           
POSTGCC_STEPS="cleanup
               licenses
               zipping"
cd $BUILD_DIR
mkdir -p $PREGCC_STEPS
mkdir -p mingw-w64-crt
mkdir -p winpthreads
mkdir -p gcc-posix
mkdir -p $POSTGCC_STEPS
cd $TOP_DIR

# Build
MAKE_OPTS='-j2'
# prepare for GCC
for step in $PREGCC_STEPS
do
    echo "-> $step"
    cd $BUILD_DIR/$step
    . $SCRIPTS/$step.sh || exit 1
done
# point PATH to new tools
export PATH=$PREFIX/bin:$PATH
# build GCC C compiler
echo "-> GCC: C compiler, win32 threads"
cd $BUILD_DIR/gcc
. $SCRIPTS/gcc-combined-c.sh || exit 1
# build mingw-w64 crt
echo "-> MinGW-w64 CRT"
cd $BUILD_DIR/mingw-w64-crt
. $SCRIPTS/mingw-w64-crt.sh || exit 1
# build libgcc
echo "-> GCC: libgcc, win32 threads"
cd $BUILD_DIR/gcc
. $SCRIPTS/libgcc.sh || exit 1
# build winpthreads
echo "-> Winpthreads"
cd $BUILD_DIR/winpthreads
. $SCRIPTS/winpthreads.sh || exit 1
# rebuild gcc and libgcc with posix threads
echo "-> GCC and libgcc, posix threads"
cd $BUILD_DIR/gcc-posix
. $SCRIPTS/gcc-combined-posix-c.sh
# build the rest of GCC
echo "-> GCC: Full compiler suite"
cd $BUILD_DIR/gcc-posix
. $SCRIPTS/gcc-combined-posix.sh || exit 1
# build the rest
for step in $POSTGCC_STEPS
do
    echo "-> $step"
    cd $BUILD_DIR/$step
    . $SCRIPTS/$step.sh || exit 1
done
