#!/usr/bin/env bash
set -e

# common settings
. ./scripts/common.sh

# Projects to be built, in the right order
PREGCC_STEPS="mingw-w64-headers
              binutils"           
POSTGCC_STEPS="cleanup
               zipping"
cd $BUILD_DIR
mkdir -p $PREGCC_STEPS
mkdir -p mingw-w64-crt
mkdir -p winpthreads
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
# build GCC C compiler
echo "-> GCC: C compiler"
cd $BUILD_DIR/gcc
. $SCRIPTS/gcc-combined-c.sh || exit 1
# build mingw-w64 crt
echo "-> MinGW-w64 CRT"
cd $BUILD_DIR/mingw-w64-crt
. $SCRIPTS/mingw-w64-crt.sh || exit 1
# build libgcc
echo "-> GCC: libgcc"
cd $BUILD_DIR/gcc
. $SCRIPTS/libgcc.sh || exit 1
# build winpthreads
echo "-> Winpthreads"
cd $BUILD_DIR/winpthreads
. $SCRIPTS/winpthreads.sh || exit 1
# build the rest of GCC
echo "-> GCC: Full compiler suite"
cd $BUILD_DIR/gcc
. $SCRIPTS/gcc-combined.sh || exit 1
# build the rest
for step in $POSTGCC_STEPS
do
    echo "-> $step"
    cd $BUILD_DIR/$step
    . $SCRIPTS/$step.sh || exit 1
done
