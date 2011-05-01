#!/usr/bin/env bash
set -e

# build the crt with the new tools
export PATH=$PREFIX/bin:$PATH

if [ -f $MARKER_DIR/mingw-w64-crt_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/mingw-w64/mingw-w64-crt/configure --host=$TARGET --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                                                  $MULTILIB \
                                                  --enable-sdk=all --enable-secure-api \
			                          CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
				                  > $LOG_DIR/mingw-w64_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch $MARKER_DIR/mingw-w64-crt_configure.marker

if [ -f $MARKER_DIR/mingw-w64-crt_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/mingw-w64-crt_build.log 2>&1 || exit 1
fi
touch $MARKER_DIR/mingw-w64-crt_build.marker
if [ -f $MARKER_DIR/mingw-w64-crt_install.marker ]
then
    echo "--> Already installed"
else
	echo "--> Installing"
	make $MAKE_OPTS install > $LOG_DIR/mingw-w64-crt_install.log 2>&1 || exit 1
fi
touch $MARKER_DIR/mingw-w64-crt_install.marker
