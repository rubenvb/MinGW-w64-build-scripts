#!/usr/bin/env bash
set -e

if [ -f cleanup.marker ]
then
  echo "--> Already cleaned up"
else
  echo "--> Cleaning up"
  cd $PREFIX
  rm -rf mingw/ || exit 1
  find . -name \*.la -exec rm -f {} \;

  # move libgcc dll to $PREFIX/bin instead of
  if [ -f "$PREFIX/lib/libgcc_s_sjlj-1.dll" ]
  then
    mv $PREFIX/lib/libgcc_s_sjlj-1.dll $PREFIX/bin/ || exit 1
  elif [ -f "$PREFIX/lib/libgcc_s_dw2-1.dll" ]
  then
    mv $PREFIX/lib/libgcc_s_dw2-1.dll $PREFIX/bin/ || exit 1
  fi

  echo "---> Stripping Executables"
  find . -name \*.exe -exec strip {} \;


  if [ "$TARGET" = "$HOST" ]
  then
    echo "---> Copying and stripping DLL's"
    $HOST-strip $PREFIX/bin/*.dll || exit 1
    # recopy python dll, stripping it breaks it
    cp $BUILD_DIR/python/bin/python27.dll $PREFIX/bin/python27.dll || exit 1
  else
    echo "---> No DLL's to copy for cross-compiler"
  fi
  
  cd $BUILD_DIR/cleanup
fi
touch cleanup.marker
