#!/usr/bin/env bash
set -e

# build the crt with the new tools
export PATH=$PREFIX/bin:$PATH

if [ -f mingw-w64-crt_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/mingw-w64/mingw-w64-crt/configure --host=$TARGET --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                                                  $CRT_MULTILIB \
                                                  --enable-sdk=all --enable-secure-api --enable-wildcard \
                                                  CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                                                  > $LOG_DIR/mingw-w64_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch mingw-w64-crt_configure.marker

if [ -f mingw-w64-crt_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/mingw-w64-crt_build.log 2>&1 || exit 1
fi
touch mingw-w64-crt_build.marker
if [ -f mingw-w64-crt_install.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
	make $MAKE_OPTS install > $LOG_DIR/mingw-w64-crt_install.log 2>&1 || exit 1

    if [[ ! $GNU_MULTILIB == "--disable-multilib" ]]
    then
        echo "--> Ugly hack to allow multilib GCC to be built"
        if [[ $TARGET == "x86_64-64W-ming32" ]]
        then
            ln -s $PREFIX/$TARGET/lib32 $PREFIX/mingw/lib
        else
            ln -s $PREFIX/$TARGET/lib64 $PREFIX/mingw/lib
        fi
    fi
fi
touch mingw-w64-crt_install.marker
