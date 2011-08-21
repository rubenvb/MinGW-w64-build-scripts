#!/usr/bin/env bash
set -e

# get version info
. ./scripts/versions.sh
# set and create directories
. ./scripts/directories.sh

# optimized for my system.
#export BUILD_CFLAGS='-O2 -mtune=core2 -fomit-frame-pointer -momit-leaf-frame-pointer -fgraphite-identity -floop-interchange -floop-block -floop-parallelize-all'
export BUILD_LDFLAGS=
export MAKE_OPTS="-j2"
