#!/usr/bin/env bash
set -e

cd $BUILD_DIR/winpthreads64

if [ -f configure.marker ]
then
  echo "--> 64-bit winpthreads already configured"
else
  echo "--> Configuring 64-bit build"
  sh $SRC_DIR/winpthreads/configure --host=x86_64-w64-mingw32 --build=$BUILD \
                                    --prefix=$PREFIX/$TARGET \
                                    --enable-shared --enable-static \
                                    > $LOG_DIR/winpthreads64_configure.log 2>&1 || exit 1
fi
touch configure.marker

if [ -f build.marker ]
then
  echo "--> 64-bit winpthreads already built"
else
  echo "--> Building 64-bit winpthreads"
  make $MAKE_OPTS > $LOG_DIR/winpthreads64_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
  echo "--> 64-bit winpthreads already installed"
else
  echo "--> Installing 64-bit winpthreads"
  make $MAKE_OPTS install > $LOG_DIR/winpthreads64_install.log 2>&1 || exit 1
  # mimic GCC runtime library behavior
  if [ "$HOST" == "x86_64-w64-mingw32" ]
  then
    mv $PREFIX/$TARGET/bin/libwinpthread-1.dll $PREFIX/bin/libwinpthread-1.dll
  else
    mv $PREFIX/$TARGET/bin/libwinpthread-1.dll $PREFIX/$TARGET/lib/libwinpthread-1.dll
  fi
fi
touch install.marker

cd $BUILD_DIR/winpthreads32

if [ -f configure.marker ]
then
  echo "--> 32-bit winpthreads already configured"
else
  echo "--> Configuring 32-bit build"
  sh $SRC_DIR/winpthreads/configure --host=i686-w64-mingw32 --build=$BUILD \
                                    --prefix=$BUILD_DIR/winpthreads32/install \
                                    --enable-shared --enable-static \
                                    > $LOG_DIR/winpthreads32_configure.log 2>&1 || exit 1
fi
touch configure.marker

if [ -f build.marker ]
then
  echo "--> 32-bit winpthreads already built"
else
  echo "--> Building 32-bit winpthreads"
  make $MAKE_OPTS > $LOG_DIR/winpthreads32_build.log 2>&1 || exit 1
fi
touch build.marker

if [ -f install.marker ]
then
  echo "--> 32-bit winpthreads already installed"
else
  echo "--> Installing 32-bit winpthreads"
  make $MAKE_OPTS install > $LOG_DIR/winpthreads32_install.log 2>&1 || exit 1

  cp -r $BUILD_DIR/winpthreads32/install/lib/* $PREFIX/$TARGET/lib32/
  cp $BUILD_DIR/winpthreads32/install/bin/libwinpthread-1.dll $PREFIX/$TARGET/lib32/libwinpthread-1.dll
fi
touch install.marker
