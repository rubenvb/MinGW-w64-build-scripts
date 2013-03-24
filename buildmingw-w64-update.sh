#!/usr/bin/env bash
set -e

echo "Building MinGW-w64 CRT/headers update package"

export UPDATE_VERSION="trunk-20130115"
export PACKAGE_NAME=mingw-w64-update-${UPDATE_VERSION}_rubenvb

export MAKE_OPTS="-j4"

export TOP_DIR=`pwd`
export SRC_DIR=$TOP_DIR/src
export BUILD_DIR=$TOP_DIR/mingw-w64-update
export PACKAGE_DIR=$TOP_DIR/packages
export LOG_DIR=$BUILD_DIR/logs

dirs_to_make="$BUILD_DIR
              $BUILD_DIR/mingw64
              $BUILD_DIR/mingw32
              $BUILD_DIR/mingw64-build
              $BUILD_DIR/mingw32-build
              $BUILD_DIR/winpthreads64
              $BUILD_DIR/winpthreads32
              $LOG_DIR
              $PACKAGE_DIR"

mkdir -p $dirs_to_make

#export PATH=$TOP_DIR/linux64mingw64/mingw64/bin:$TOP_DIR/linux64mingw32/mingw32/bin:$PATH

echo "-> Building 64-bit MinGW-w64"
cd $BUILD_DIR/mingw64-build
sh $SRC_DIR/mingw-w64/configure --host=x86_64-w64-mingw32 --build=x86_64-linux-gnu --target=x86_64-w64-mingw32 \
                                --prefix=$BUILD_DIR/mingw64/x86_64-w64-mingw32 \
                                --enable-sdks=all --enable-wildcard --enable-secure-api \
                                --enable-lib64 --disable-lib32 \
                                > $LOG_DIR/mingw-w64-64-bit_configure.log 2>&1 || exit 1
make ${MAKE_OPTS} > $LOG_DIR/mingw-w64-64-bit_build.log 2>&1  || exit 1
make install > $LOG_DIR/mingw-w64-64-bit_install.log 2>&1 || exit 1

echo "-> Building 32-bit MinGW-w64"
cd $BUILD_DIR/mingw32-build
sh $SRC_DIR/mingw-w64/configure --host=i686-w64-mingw32 --build=x86_64-linux-gnu --target=i686-w64-mingw32 \
                                --prefix=$BUILD_DIR/mingw32/i686-w64-mingw32 \
                                --enable-sdks=all --enable-wildcard --enable-secure-api \
                                --enable-lib32 --disable-lib64 \
                                > $LOG_DIR/mingw-w64-32-bit_configure.log 2>&1 || exit 1
make ${MAKE_OPTS} > $LOG_DIR/mingw-w64-32-bit_build.log 2>&1 || exit 1
make install > $LOG_DIR/mingw-w64-32-bit_install.log 2>&1  || exit 1

echo "-> Building 64-bit winpthreads"
cd $BUILD_DIR/winpthreads64
sh $SRC_DIR/winpthreads/configure --host=x86_64-w64-mingw32 --prefix=$BUILD_DIR/mingw64/x86_64-w64-mingw32 \
                                  --enable-shared --enable-static \
                                  > $LOG_DIR/winpthreads-64-bit_configure.log 2>&1 || exit 1
make ${MAKE_OPTS} > $LOG_DIR/winpthreads-64-bit_build.log 2>&1 || exit 1
make install > $LOG_DIR/winpthreads-32-bit_install.log 2>&1 || exit 1

echo "-> Building 32-bit winpthreads"
cd $BUILD_DIR/winpthreads64
sh $SRC_DIR/winpthreads/configure --host=i686-w64-mingw32 --prefix=$BUILD_DIR/mingw32/i686-w64-mingw32 \
                                  --enable-shared --enable-static \
                                  > $LOG_DIR/winpthreads-32-bit_configure.log 2>&1 || exit 1
make ${MAKE_OPTS} > $LOG_DIR/winpthreads-64-bit_build.log 2>&1 || exit 1
make install > $LOG_DIR/winpthreads-64-bit_install.log 2>&1 || exit 1

cd $BUILD_DIR
TAR_COMPRESS="tar -Jhcf"
BIN_COMPRESS="7za -l -bd -mx9 a"

echo "-> Creating 64-bit packages"
$TAR_COMPRESS $PACKAGE_DIR/x86_64-w64-mingw32-$PACKAGE_NAME.tar.xz mingw64 > $LOG_DIR/package-64-bit-tar.log 2>&1 || exit 1
$BIN_COMPRESS $PACKAGE_DIR/x86_64-w64-mingw32-$PACKAGE_NAME.7z mingw64 > $LOG_DIR/package-64-bit-7z.log 2>&1 || exit 1

echo "-> Creating 32-bit packages"
$TAR_COMPRESS $PACKAGE_DIR/i686-w64-mingw32-$PACKAGE_NAME.tar.xz mingw32 > $LOG_DIR/package-32-bit-tar.log 2>&1 || exit 1
$BIN_COMPRESS $PACKAGE_DIR/i686-w64-mingw32-$PACKAGE_NAME.7z mingw32 > $LOG_DIR/package-32-bit-7z.log 2>&1 || exit 1
                             