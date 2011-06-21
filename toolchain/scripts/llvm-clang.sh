#!/usr/bin/env bash
set -e

if [ -f llvm-clang_configure.marker ]
then
    echo "--> Already configured"
else
    echo "--> Configuring"
    sh $SRC_DIR/LLVM/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                               CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                               > $LOG_DIR/llvm-clang_configure.log 2>&1 || exit 1
    echo "--> Configured"
fi
touch llvm-clang_configure.marker

if [ -f llvm-clang_build.marker ]
then
    echo "--> Already built"
else
    echo "--> Building"
    make $MAKE_OPTS > $LOG_DIR/llvm-clang_build.log 2>&1 || 
exit 1
fi
touch llvm-clang_build.marker
if [ -f llvm-clang_install.marker ]
then
    echo "--> Already installed"
else
    echo "--> Installing"
    make $MAKE_OPTS install > $LOG_DIR/llvm-clang_install.log 2>&1 || exit 1
fi
touch llvm-clang_install.marker
