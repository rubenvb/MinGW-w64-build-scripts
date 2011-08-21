#!/usr/bin/env bash
set -e

# combined gcc tree symlinks
if [ -f $GCC_SRC/symlinks.marker ]
then
    echo "-> GCC combined tree already in place"
else
    echo "-> Creating GCC/GDB combined tree symlinks"
    if [ "$HOST" == "i686-w64-mingw32" ] || [ "$HOST" == "x86_64-w64-mingw32" ]
    then
        ln -s $SRC_DIR/gdb/* $GCC_SRC/
    fi
    ln -s $SRC_DIR/gcc/* $GCC_SRC/
    ln -s $SRC_DIR/libiconv-$LIBICONV_VERSION/* $GCC_SRC/libiconv/
    ln -s $SRC_DIR/gmp-$GMP_VERSION/* $GCC_SRC/gmp/
    ln -s $SRC_DIR/mpfr-$MPFR_VERSION/* $GCC_SRC/mpfr/
    ln -s $SRC_DIR/mpc-$MPC_VERSION/* $GCC_SRC/mpc/
    ln -s $SRC_DIR/ppl-$PPL_VERSION/* $GCC_SRC/ppl/
    ln -s $SRC_DIR/cloog-$CLOOG_VERSION/* $GCC_SRC/cloog/
    echo "-> Done"
fi
touch $GCC_SRC/symlinks.marker
