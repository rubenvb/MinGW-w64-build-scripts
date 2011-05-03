#!/usr/bin/env bash
set -e

#platforms
export HOST=x86_64-w64-mingw32
export TARGET=x86_64-w64-mingw32
export BUILD=x86_64-gnu-linux
export EXESUFFIX=".exe"
export BUILD_BOOTSTRAP= #profiledbootstrap
export SHORTNAME=mingw64
# options
export GCC_LANGUAGES="c,c++,fortran,objc,obj-c++"
export BUILD_CORES=2 #used as argument for "make -j#"
export SHARED='--enable-shared'
export CRT_MULTILIB='--disable-lib32 --enable-lib64'
export GNU_MULTILIB='--enable-targets=i686-w64-mingw32,x86_64-w64-mingw32'
export GNU_WIN32_OPTIONS='--disable-win32-registry --disable-rpath --disable-werror'
# directories: SRC_DIR contains full source package.
export TOP_DIR=`pwd`
export SRC_DIR=$TOP_DIR/src
export BUILD_DIR=$TOP_DIR/x64
export LOG_DIR=$BUILD_DIR/logs
export SCRIPTS=$TOP_DIR/scripts
export MARKER_DIR=$BUILD_DIR/markers
export PREFIX=$BUILD_DIR/$SHORTNAME
export GCC_LIBS=$BUILD_DIR/libs
DIRS_TO_MAKE="$BUILD_DIR $LOG_DIR $PREFIX $GCC_LIBS $MARKER_DIR
              $PREFIX/mingw/include $PREFIX/$TARGET/include"
mkdir -p $DIRS_TO_MAKE

# optimized for my system.
export BUILD_CFLAGS='-O2 -mtune=core2 -fomit-frame-pointer -momit-leaf-frame-pointer'
export BUILD_LDFLAGS=
export BUILD_CFLAGS_LTO=$BUILD_CFLAGS #' -flto'
export BUILD_LDFLAGS_LTO=$BUILD_LDFLAGS #' -flto='$BUILD_CORES
export MAKE_OPTS="-j"$BUILD_CORES

#get version info
. ./versions.sh

# Projects to be built, in the right order
PROJECTS="expat libiconv
          gmp mpfr mpc
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
# build directories
echo "Creating build directories"
cd $BUILD_DIR
mkdir -p $PROJECTS
cd $TOP_DIR
echo "Building prerequisites"
for project in $PROJECTS
do
    cd $BUILD_DIR/$project
    echo "-> $project"
    . $SCRIPTS/$project.sh || exit 1
    cd $TOP_DIR
done
		  
		  
