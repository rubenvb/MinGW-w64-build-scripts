
echo "Setting up environment for MinGW-w64 GCC 64-bit default target..."

:: Toolchain
@set PATH=%CD%\bin;%CD%\x86_64-w64-mingw32\lib32;%PATH%
