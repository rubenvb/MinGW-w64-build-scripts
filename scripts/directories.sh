#!/usr/bin/env bash
# sets and creates directories used elsewhere
# requires LONG_NAME, SHORT_NAME, HOST, MINGW_W64_VERSION
set -e

# directories
export TOP_DIR=`pwd`
export SRC_DIR=$TOP_DIR/src
export BUILD_DIR="$TOP_DIR/$LONG_NAME"
export PACKAGE_DIR=$TOP_DIR/packages
export LOG_DIR=$BUILD_DIR/logs

if [ "$HOST" = "i686-w64-mingw32" ] && [ "$SHORT_NAME" = "mingw32-dw2" ]
then
  export PREREQ_DIR="$TOP_DIR/prereq/$HOST-dw2"
else
  export PREREQ_DIR="$TOP_DIR/prereq/$HOST"
fi
export PREREQ_INSTALL="$PREREQ_DIR/install"

export SCRIPTS=$TOP_DIR/scripts

export PREFIX=$BUILD_DIR/$SHORT_NAME

DIRS_TO_MAKE="$BUILD_DIR $LOG_DIR
              $PREFIX $PREFIX/mingw $PREFIX/mingw/include $PREFIX/$TARGET/include $PREFIX/$TARGET/lib
              $PREREQ_INSTALL $PREREQ_INSTALL/lib $PREREQ_INSTALL/include
              $PACKAGE_DIR $PACKAGE_DIR/$HOST"
mkdir -p $DIRS_TO_MAKE

# if [ "$TARGET_ARCH" = "i686" ]
# then
#   mkdir -p $PREFIX/$TARGET/lib64
#   rm -f $PREFIX/mingw/include
#   rm -f $PREFIX/mingw/lib64
#   rm -f $PREFIX/mingw/lib
#   ln -s $PREFIX/$TARGET/include $PREFIX/mingw/include
#   ln -s $PREFIX/$TARGET/lib $PREFIX/mingw/lib
#   ln -s $PREFIX/$TARGET/lib64 $PREFIX/mingw/lib64
# elif [ "$TARGET_ARCH" = "x86_64" ]
# then
#   mkdir -p $PREFIX/$TARGET/lib32
#   rm -f $PREFIX/mingw/include
#   rm -f $PREFIX/mingw/lib32
#   rm -f $PREFIX/mingw/lib
#   ln -s $PREFIX/$TARGET/include $PREFIX/mingw/include
#   ln -s $PREFIX/$TARGET/lib $PREFIX/mingw/lib
#   ln -s $PREFIX/$TARGET/lib32 $PREFIX/mingw/lib32
# else
#   echo "ERROR, unknown target architecture."
#   exit 1
# fi