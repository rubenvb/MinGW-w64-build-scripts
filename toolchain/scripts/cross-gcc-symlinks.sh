#!/usr/bin/env bash
set -e

if [ -f gcc_cross_symlinks.marker ]
then
    echo "--> Symlinked source directory already present"
else
    echo "--> Creating symlinks to build a cross-toolchain with static dependencies"
    # remove previous symlinks
    rm $GCC_SRC
    # make new ones
    ln -s $SRC_DIR/gcc                  $GCC_SRC/
    ln -s $SRC_DIR/gmp-$GMP_VERSION     $GCC_SRC/gmp
    ln -s $SRC_DIR/mpfr-$MPFR_VERSION   $GCC_SRC/mpfr
    ln -s $SRC_DIR/mpc-$MPC_VERSION     $GCC_SRC/mpc
    ln -s $SRC_DIR/ppl-$PPL_VERSION     $GCC_SRC/ppl
    ln -s $SRC_DIR/cloog-$CLOOG_VERSION $GCC_SRC/cloog
    exit 1
fi
touch gcc_cross_symlinks.marker