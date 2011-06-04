#!/usr/bin/env bash
set -e

if [ -f create_gcc_symlinks.marker ]
then
    echo "--> Symlinked source directory already present"
else
    echo "--> Creating symlinks to build a cross-toolchain with static dependencies"
    # remove previous symlink
    rm -f $GCC_SRC
    # make new ones
    ln -s $SRC_DIR/gcc                        $GCC_SRC
    ln -s $SRC_DIR/libiconv-$LIBICONV_VERSION $GCC_SRC/libiconv
    ln -s $SRC_DIR/expat-$EXPAT_VERSION       $GCC_SRC/expat
    ln -s $SRC_DIR/gmp-$GMP_VERSION           $GCC_SRC/gmp
    ln -s $SRC_DIR/mpfr-$MPFR_VERSION         $GCC_SRC/mpfr
    ln -s $SRC_DIR/mpc-$MPC_VERSION           $GCC_SRC/mpc
    ln -s $SRC_DIR/ppl-$PPL_VERSION           $GCC_SRC/ppl
    ln -s $SRC_DIR/cloog-$CLOOG_VERSION       $GCC_SRC/cloog
fi
touch create_gcc_symlinks.marker