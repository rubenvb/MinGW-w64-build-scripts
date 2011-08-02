#!/usr/bin/env bash
set -e

# use freshly built tools
export PATH=$PREFIX/bin:$PATH

if [ -f gcc-c2_complete.marker ]
then
    echo "--> Bootstrapping crt+winpthreads already completed"
else
    ##
    # work around cyclic winpthreads<->libgcc dependency
    # 1. use present gcc (win32 threads) and crt to build libgcc
    # 2. build winpthreads
    # 3. build new gcc-c (posix threads) with libgcc
    # 4. build new winpthreads
    # 5. rebuild libgcc with good winpthreads
    # next step will rebuild winpthreads with new libgcc
    echo "-> Step 1: build libgcc (win32 threads)"
    if [ -f libgcc.marker ]
    then
        echo "--> Already built"
    else
        echo "--> Building"
        cd $BUILD_DIR/gcc-c
        make $MAKE_OPTS all-target-libgcc > $LOG_DIR/gcc-c-libgcc_build.log 2>&1 || exit 1
        echo "--> Installing"
        make $MAKE_OPTS install-target-libgcc > $LOG_DIR/gcc-c-libgcc_install.log 2>&1 || exit 1
    fi
    touch libgcc.marker

    echo "-> Step 2: build winpthreads with libgcc (win32 threads)"
    rm -rf $BUILD_DIR/winpthreads
    mkdir -p $BUILD_DIR/winpthreads
    cd $BUILD_DIR/winpthreads
    . $SCRIPTS/winpthreads.sh || exit 1

    cd $BUILD_DIR/gcc-c2
    echo "-> Step 3: build gcc C compiler+libgcc with posix threads"
    if [ -f configure.marker ]
    then
        echo "--> Already configured"
    else
        echo "--> Configuring"
        sh $GCC_SRC/configure --host=$HOST --build=$BUILD --target=$TARGET --with-sysroot=$PREFIX --prefix=$PREFIX \
                              $GCC_PREREQUISITES --enable-threads=posix \
                              --enable-languages=c --enable-libgomp --enable-checking=release \
                              --enable-fully-dynamic-string \
                              $GNU_EXTRA_OPTIONS \
                              $GNU_MULTILIB $SHARED \
                              $GNU_WIN32_OPTIONS \
                              CFLAGS="$BUILD_CFLAGS_LTO" LDFLAGS="$BUILD_LDFLAGS_LTO" \
                              > $LOG_DIR/gcc-c2_configure.log 2>&1 || exit 1
        echo "--> Configured"
    fi
    touch configure.marker

    if [ -f build.marker ]
    then
        echo "--> Already built"
    else
        echo "--> Building"
        make $MAKE_OPTS all-gcc > $LOG_DIR/gcc-c2_build.log 2>&1 || exit 1
        echo "---> Building libgcc"
        make $MAKE_OPTS all-target-libgcc > $LOG_DIR/gcc-c2-libgcc_build.log 2>&1 || exit 1
    fi
    touch build.marker

    if [ -f install.marker ]
    then
        echo "--> Already installed"
    else
        echo "--> Installing"
        make $MAKE_OPTS install-gcc > $LOG_DIR/gcc-c_install.log 2>&1 || exit 1
        make $MAKE_OPTS install-target-libgcc > $LOG_DIR/gcc-c2-libgcc_install.log 2>&1 || exit 1
    fi
    touch install.marker

    echo "-> Step 4: new winpthreads"
    rm -rf $BUILD_DIR/winpthreads
    mkdir -p $BUILD_DIR/winpthreads
    cd $BUILD_DIR/winpthreads
    . $SCRIPTS/winpthreads.sh || exit 1

    echo "-> Step 5: rebuild libgcc with new winpthreads"
    cd $BUILD_DIR/gcc-c2
    rm -rf $TARGET/libgcc
    make $MAKE_OPTS all-target-libgcc > $LOG_DIR/gcc-c2-libgcc_build2.log 2>&1 || exit 1
    make $MAKE_OPTS install-target-libgcc > $LOG_DIR/gcc-c2-libgcc_install2.log 2>&1 || exit 1

    echo "-> Done jumping through hoops!"
    cd $BUILD_DIR/gcc-c2
fi
touch complete.marker


