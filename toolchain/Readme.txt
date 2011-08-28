Rubenvb's MinGW-w64 build scripts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

0. License
----------
The license on the files in the patches, scripts and main directory is the most permissive license you can think of.
The build script files are free for all uses, except legal action against the author.

1. How to use
-------------
Please download a source package for a previous rubenvb build from the mingw-w64 Sourceforge downloads page to see 
what directories need to be present in the src subdirectory.

1.1 Prerequisites
-----------------
All scripts assume a Fedora 15 64-bit build box, with all relevant cross-compilers and tools installed. You can find
the cross-compilers used here:
Mac OS X: http://build1.openftd.org/fedora-cross-darwinx
Cygwin:   ftp://ftp.cygwinports.org/pub/cygwinports
The native and cross Windows compilers can be built from a native Linux toolchain Fedora provides.

The tools you will need are:
make
flex
bison
gcc (native)
binutils (native)
makeinfo
7za (for windows hosted binary package creation)
lzma (for source and other platform binary package creation)
