#!/usr/bin/env bash
set -e

if [ -f gdb_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/gdb/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                              --with-libiconv-prefix=$GCC_LIBS --with-libexpat-prefix=$GCC_LIBS \
                              $GNU_EXTRA_OPTIONS --with-python \
                              $GNU_MULTILIB \
                              $GNU_WIN32_OPTIONS \
                              CFLAGS="$BUILD_CFLAGS_LTO $GDB_PYTHON_WIN64_WORKAROUND -I$BUILD_DIR/python/include" LDFLAGS="$BUILD_LDFLAGS_LTO -L$BUILD_DIR/python" \
                              > $LOG_DIR/gdb_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch gdb_configure.marker

if [ -f gdb_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
	make $MAKE_OPTS > $LOG_DIR/gdb_build.log 2>&1 || 
exit 1
fi
touch gdb_build.marker
if [ -f gdb_install.marker ]
then
    echo "--> Already installed"
else
	make $MAKE_OPTS install > $LOG_DIR/gdb_install.log 2>&1 || 
exit 1
fi
touch gdb_install.marker
