#!/usr/bin/env bash
set -e

if [ -f $MARKER_DIR/gdb_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/gdb/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
		              --with-libiconv-prefix=$GCC_LIBS --with-libexpat-prefix=$GCC_LIBS \
			     --disable-nls \
                              --disable-multilib \
			      --disable-rpath --disable-win32-registry \
                              CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                              > $LOG_DIR/gdb_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch $MARKER_DIR/gdb_configure.marker

if [ -f $MARKER_DIR/gdb_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/gdb_build.log 2>&1 || 
exit 1
fi
touch $MARKER_DIR/gdb_build.marker
if [ -f $MARKER_DIR/gdb_install.marker ]
then
    echo "--> Already installed"
else
	make $MAKE_OPTS install > $LOG_DIR/gdb_install.log 2>&1 || 
exit 1
fi
touch $MARKER_DIR/gdb_install.marker
