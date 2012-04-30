#!/usr/bin/env bash
set -e

# build options - for my system only
export BUILD=x86_64-linux-gnu
export MAKE_OPTS="-j4"
export HOST_CFLAGS="-O2 -march=nocona -mtune=core2"
export HOST_LDFLAGS= #"-flto"
if [ "$HOST_VENDOR" != "apple" ]
then
  export HOST_CFLAGS="$HOST_CFLAGS -fomit-frame-pointer -momit-leaf-frame-pointer -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all"
  #if [ "$HOST_OS" != "mingw32" ] && [ "$HOST_OS" != "cygwin" ]
  #then
    # Linux GCC was failing with this
  #  export HOST_CFLAGS="$HOST_CFLAGS -flto"
  #fi
fi
# GCC languages to be built
export GCC_LANGUAGES='c,lto,c++,objc,obj-c++,fortran,java' #go,ada

# get version info
echo "-> Loading version info"
. ./scripts/versions.sh || exit 1
# set and create directories
echo "-> Setting up directories"
. ./scripts/directories.sh || exit 1
# multilib wrapper scripts
# echo "-> Setting up multilib wrapper scripts"
# . ./scripts/fakegcc.sh
