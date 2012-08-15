#!/usr/bin/env bash
set -e

# build options - for my system only, change if you want/need
export BUILD="x86_64-linux-gnu"
export MAKE_OPTS="-j4"
export HOST_CFLAGS="-O2 -march=nocona -mtune=core2"
#export HOST_CFLAGS="$HOST_CFLAGS -flto"
#export HOST_LDFLAGS="$HOST_LDFLAGS -flto"
if [ "$HOST" = "i686-w64-mingw32" ] || [ "$HOST" = "i686-pc-cygwin" ]
then
  HOST_LDFLAGS="$HOST_LDFLAGS -Wl,--large-address-aware"
fi
if [ "$HOST_VENDOR" = "apple" ]
then
  HOST_CC="$HOST-gcc --sysroot /home/ruben/darwin/MacOSX10.7.sdk"
  HOST_CXX="$HOST-g++ --sysroot /home/ruben/darwin/MacOSX10.7.sdk"
  HOST_LDFLAGS="$HOST_LDFLAGS --sysroot /home/ruben/darwin/MacOSX10.7.sdk"
elif [ "$HOST_OS" = "cygwin" ]
then
  export HOST_CFLAGS="$HOST_CFLAGS -fomit-frame-pointer -momit-leaf-frame-pointer"
else
  export HOST_CFLAGS="$HOST_CFLAGS -fomit-frame-pointer -momit-leaf-frame-pointer" # -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all"
fi

case `$HOST-gcc -dumpversion` in
  "4.5.?")
    if [ "$HOST_OS" != "cygwin" ]
    then
      export HOST_CFLAGS="$HOST_CFLAGS -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all"
    fi
  ;;
  "4.6.?")
    export HOST_CFLAGS="$HOST_CFLAGS -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all"
    ;;
  "4.7.?")
    export HOST_CFLAGS="$HOST_CFLAGS -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all"
    ;;
  "4.8.?")
    export HOST_CFLAGS="$HOST_CFLAGS -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all"
    ;;
esac

# GCC languages to be built
export GCC_LANGUAGES='c,lto,c++,objc,obj-c++,fortran,java' #go,ada
# extra options to GCC
#if [ "$TARGET_ARCH" = "i686" ]
#then
#  EXTRA_OPTIONS="$EXTRA_OPTIONS --enable-libgcj"
#fi
if [ "$SHORT_NAME" = "mingw32-dw2" ]
then
  EXTRA_OPTIONS="$EXTRA_OPTIONS --enable-dw2-exceptions --disable-sjlj-exceptions"
elif [ "$SHORT_NAME" = "mingw64" ]
then
  EXTRA_OPTIONS=$EXTRA_OPTIONS
else
  EXTRA_OPTIONS="$EXTRA_OPTIONS --disable-dw2-exceptions --enable-sjlj-exceptions"
fi
