#!/usr/bin/env bash
set -e

# build options - for my system only, change if you want/need
export BUILD=x86_64-linux-gnu
export MAKE_OPTS="-j4"
export HOST_CFLAGS="-O2 -march=nocona -mtune=core2"
#export HOST_CFLAGS="$HOST_CFLAGS -flto"
#export HOST_LDFLAGS="$HOST_LDFLAGS -flto"
if [ "$HOST" == "i686-apple-darwin11" ]
then
  HOST_CFLAGS="$HOST_CFLAGS --sysroot /home/ruben/darwin/MacOSX10.7.sdk"
  HOST_LDFLAGS="$HOST_LDFLAGS --sysroot /home/ruben/darwin/MacOSX10.7.sdk"
else
  export HOST_CFLAGS="$HOST_CFLAGS -fomit-frame-pointer -momit-leaf-frame-pointer -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all"
fi

# GCC languages to be built
export GCC_LANGUAGES='c,lto,c++,objc,obj-c++,fortran,java' #go,ada
# extra options to GCC
#if [ "$TARGET_ARCH" == "i686" ]
#then
#  EXTRA_OPTIONS="$EXTRA_OPTIONS --enable-libgcj"
#fi
if [ "$SHORT_NAME" == "mingw32-dw2" ]
then
  EXTRA_OPTIONS="$EXTRA_OPTIONS --enable-dw2-exceptions --disable-sjlj-exceptions"
elif [ "$SHORT_NAME" == "mingw64" ]
then
  EXTRA_OPTIONS=$EXTRA_OPTIONS
else
  EXTRA_OPTIONS="$EXTRA_OPTIONS --disable-dw2-exceptions --enable-sjlj-exceptions"
fi
