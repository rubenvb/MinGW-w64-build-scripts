#!/usr/bin/env bash
set -e

# build options - for my system only
export BUILD=x86_64-linux-gnu
export MAKE_OPTS="-j2"

# GCC languages to be built
export GCC_LANGUAGES='c,lto,c++,fortran,objc,obj-c++,java'
if [ "$HOST_OS" != "darwin10" ] && [ "$HOST_OS" != "cygwin" ]
then
    export GCC_LANGUAGES=$GCC_LANGUAGES',ada'
fi

# get version info
echo "-> Loading version info"
. ./scripts/versions.sh || exit 1
# set and create directories
echo "-> Setting up directories"
. ./scripts/directories.sh || exit 1
# symlinks
#echo "-> Setting up source tree symlinks"
#. ./scripts/symlinks.sh || exit 1
# multilib wrapper scripts
echo "-> Setting up multilib wrapper scripts"
. ./scripts/fakegcc.sh
