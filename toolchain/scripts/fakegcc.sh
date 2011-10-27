#!/usr/bin/env bash
# sets path to point to multilib wrappers for GCC when building for the other bitness.
set -e

if [ "$HOST_VENDOR" == "linux" ]
then
    TRUE_ARCH=`/bin/arch`
    if [ "$HOST_ARCH" == "x86_64" ] && [ "$TRUE_ARCH" == "i686" ]
    then
        export PATH=$FAKEGCC_PATH/linuxfrom32to64:$PATH
    elif [ "$HOST_ARCH" == "i686" ] && [ "$TRUE_ARCH" == "x86_64" ]
    then
        export PATH=$FAKEGCC_PATH/linuxfrom64to32:$PATH
    fi
fi

if [ "$HOST_VENDOR" == "apple" ]
then
    if [ "$HOST_ARCH" == "x86_64" ]
    then
        export PATH=$FAKEGCC_PATH/macfrom32to64:$PATH
    fi
fi