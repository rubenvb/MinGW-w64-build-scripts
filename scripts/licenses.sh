#!/usr/bin/env bash
set -e

if [ -f licenses.marker ]
then
  echo "--> Licenses already installed"
else
  echo "--> Copying licenses"
  echo "---> Binutils/GDB"
  mkdir -p binutils
  mkdir -p gdb
  LICENSES="COPYING COPYING.LIB COPYING3 COPYING3.LIB"
  for file in $LICENSES
  do
    cp $SRC_DIR/binutils/$file binutils/$file
    if [ "$HOST" = "x86_64-w64-mingw32" ] || [ "$HOST" = "i686-w64-mingw32" ]
    then
      cp $SRC_DIR/gdb/$file gdb/$file
    fi
  done

  echo "---> CLooG"
  mkdir -p cloog
  echo "http://www.gnu.org/licenses/lgpl-2.1.html" > cloog/license.txt

  echo "---> ISL"
  mkdir -p isl
  echo "http://www.gnu.org/licenses/lgpl-2.1.html" > isl/license.txt

  echo "---> GCC"
  mkdir -p gcc
  LICENSES="COPYING COPYING.LIB COPYING.RUNTIME COPYING3 COPYING3.LIB"
  for file in $LICENSES
  do
    cp $SRC_DIR/gcc/$file gcc/$file
  done

  echo "---> GMP"
  mkdir -p gmp
  cp $SRC_DIR/gmp/COPYING gmp/COPYING
  cp $SRC_DIR/gmp/COPYING.LIB gmp/COPYING.LIB

  echo "---> libiconv"
  mkdir -p libiconv
  cp $SRC_DIR/libiconv/COPYING libiconv/COPYING
  cp $SRC_DIR/libiconv/COPYING.LIB libiconv/COPYING.LIB

  echo "---> mingw-w64"
  mkdir -p mingw-w64
  cp $SRC_DIR/mingw-w64/COPYING.MinGW-w64/COPYING.MinGW-w64.txt mingw-w64/COPYING.MinGW-w64.txt
  cp $SRC_DIR/mingw-w64/COPYING.MinGW-w64-runtime/COPYING.MinGW-w64-runtime.txt mingw-w64/COPYING.MinGW-w64-runtime.txt
  cp $SRC_DIR/mingw-w64/COPYING mingw-w64/COPYING
  cp $SRC_DIR/mingw-w64/DISCLAIMER mingw-w64/DISCLAIMER
  cp $SRC_DIR/mingw-w64/DISCLAIMER.PD mingw-w64/DISCLAIMER.PD
  cp $SRC_DIR/mingw-w64/mingw-w64-headers/ddk/readme.txt mingw-w64/ddk-readme.txt
  cp $SRC_DIR/mingw-w64/mingw-w64-headers/direct-x/COPYING.LIB mingw-w64/direct-x-COPYING.lib
  cp $SRC_DIR/mingw-w64/mingw-w64-headers/direct-x/readme.txt mingw-w64/direct-x-readme.txt

  echo "---> MPC"
  mkdir -p mpc
  cp $SRC_DIR/mpc/COPYING.LESSER mpc/COPYING.LESSER

  echo "---> MPFR"
  mkdir -p mpfr
  cp $SRC_DIR/mpfr/COPYING mpfr/COPYING
  cp $SRC_DIR/mpfr/COPYING.LESSER mpfr/COPYING.LESSER
    
  echo "---> PPL"
  mkdir -p ppl
  cp $SRC_DIR/ppl/COPYING ppl/COPYING

  echo "---> Winpthreads"
  mkdir -p winpthreads
  cp $SRC_DIR/winpthreads/COPYING winpthreads/COPYING

  if [ "$HOST" != "x86_64-w64-mingw32" ] && [ "$HOST" != "i686-w64-mingw32" ]
  then
    echo "---> Skipping Make, expat, and Python"
  else
    echo "---> Make"
    mkdir -p make
    cp $SRC_DIR/make/COPYING make/COPYING
    
    echo "---> Expat"
    mkdir -p expat
    cp $SRC_DIR/expat/COPYING expat/COPYING

    echo "---> Python"
    mkdir -p python
    cp $BUILD_DIR/python/LICENSE.txt python/LICENSE.txt
  fi

  mkdir -p $PREFIX/licenses
  cp -r . $PREFIX/licenses
  echo "---> Done!"
fi
touch licenses.marker
