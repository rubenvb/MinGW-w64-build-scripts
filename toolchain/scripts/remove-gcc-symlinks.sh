#!/usr/bin/env bash
set -e

if [ -f remove_gcc_symlinks.marker ]
then
    echo "--> Symlinked source directory already present"
else
    echo "--> Removing symlinks to build a cross-toolchain with static dependencies"
    # remove symlinks
    rm $GCC_SRC/libiconv
    rm $GCC_SRC/expat
    rm $GCC_SRC/gmp
    rm $GCC_SRC/mpfr
    rm $GCC_SRC/mpc
    rm $GCC_SRC/ppl
    rm $GCC_SRC/cloog
    rm $GCC_SRC
fi
touch remove_gcc_symlinks.marker