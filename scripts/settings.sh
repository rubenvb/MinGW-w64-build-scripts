#!/usr/bin/env bash
set -e

# build options - for my system only, change if you want/need
export BUILD=x86_64-linux-gnu
export MAKE_OPTS="-j4"
export HOST_CFLAGS="-O2 -march=nocona -mtune=core2"
#export HOST_CFLAGS="$HOST_CFLAGS -flto"
#export HOST_LDFLAGS="$HOST_LDFLAGS -flto"
export HOST_CFLAGS="$HOST_CFLAGS -fomit-frame-pointer -momit-leaf-frame-pointer -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all"

# GCC languages to be built
export GCC_LANGUAGES='c,lto,c++,objc,obj-c++,fortran,java' #go,ada
