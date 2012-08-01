Welcome to rubenvb's toolchain sources where all the source code is.

The subdirectories contain the sources for all the binary toolchain packages.
If you want to use MinGW-w64 and GCC, these are not for you. These are only
provided for legal purposes and for those who want to build for a platform I
cannot currently build binary packages for.

The packages contain everything necessary, including all source code and the
scripts used to build my packages on Arch Linux.

The settings you will have to adjust for your system are in
./scripts/settings.sh

To build all the packages  I uploaded, just run
./buildall.sh

To not run into any weird errors, you'll need the following programs installed:
 - flex
 - bison
 - texinfo
 - p7zip
 - make
 - gcc
 - unzip
 - tar
 - bzip2
 -...

If any of these programs are not installed, you will get a very undescriptive error
at best. Ideally, everything will go fine. If not, contact me via the mingw-w64-public
mailing list or the mingw-w64 forums.