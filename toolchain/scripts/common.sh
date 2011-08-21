#!/usr/bin/env bash
set -e

# get version info
echo "-> Loading version info"
. ./scripts/versions.sh || exit 1
# set and create directories
echo "-> Setting up directories"
. ./scripts/directories.sh || exit 1
# symlinks
echo "-> Setting up source tree symlinks"
. ./scripts/symlinks.sh || exit 1

# optimized for my system.
#export BUILD_CFLAGS='-O2 -mtune=core2 -fomit-frame-pointer -momit-leaf-frame-pointer -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all'
export BUILD_LDFLAGS=
export MAKE_OPTS="-j2"
