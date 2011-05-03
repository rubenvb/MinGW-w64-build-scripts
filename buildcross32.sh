#!/usr/bin/env bash
set -e

# platform information
export HOST=i686-linux-gnu
export TARGET=i686-w64-mingw32
export BUILD=x86_64-linux-gnu
export EXESUFFIX=
export BUILD_BOOTSTRAP=
export SHORTNAME=mingw32
# options
export GCC_LANGUAGES="c,c++,fortran,objc,obj-c++"
export BUILD_CORES=2 #used as argument for "make -jn"
export SHARED='--enable-static --enable-shared'
export MULTILIB='--enable-lib32 --disable-lib64'
export GCC_WIN32_OPTIONS=
# directories: SRC_DIR contains full source package.
export TOP_DIR=`pwd`
export SRC_DIR=$TOP_DIR/src
export BUILD_DIR=$TOP_DIR/cross32
export LOG_DIR=$BUILD_DIR/logs
export SCRIPTS=$TOP_DIR/scripts
export MARKER_DIR=$BUILD_DIR/markers
export PREFIX=$BUILD_DIR/$SHORTNAME
DIRS_TO_MAKE="$BUILD_DIR $LOG_DIR $PREFIX $GCC_LIBS $MARKER_DIR
              $PREFIX/mingw/include $PREFIX/$TARGET/include"
mkdir -p $DIRS_TO_MAKE

# optimized for my system.
export BUILD_CFLAGS='-O2 -mtune=core2 -fomit-frame-pointer -momit-leaf-frame-pointer'
export BUILD_LFLAGS=
export BUILD_CFLAGS_LTO=$BUILD_CFLAGS #' -flto'
export BUILD_LFLAGS_LTO=$BUILD_LFLAGS #' -flto='$BUILD_CORES
export MAKE_OPTS="-j"$BUILD_CORES

#get version info
. ./versions.sh

# Projects to be built, in the right order
export PROJECTS="mingw-w64-headers
                 pthreads
                 binutils
                 gcc-c
                 mingw-w64-crt
                 gcc
                 cleanup"
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
		  
		  
