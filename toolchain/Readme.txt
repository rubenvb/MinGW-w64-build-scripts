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
unzip (for Windows native builds and extraction of the python dll's)
(maybe others I forgot to mention here)

1.2. How to build
-----------------
In the toplevel directory there are a bunch of build*.sh scripts. These are the ones you'll need to call.
If you're not on a 64-bit Linux build machine, you'll need to change the value of the BUILD variable in
scripts/common.sh to whatever your host triplet should be. And hope the scripts will work for your particular combination :)

Native Windows bootstraps are not supported yet, a GCC build system patch will need to land first for that to work.