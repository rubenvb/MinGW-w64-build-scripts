Welcome to rubenvb/release. This is where the stable stuff is.

You will find the latest MinGW-w64 GCC toolchains here, which include:
 - GCC: compiler for (obj-)c(++), fortran, 

Currently, there are three major GCC releases:
 - GCC 4.5
 - GCC 4.6
 - GCC 4.7

I always recommend using the latest release, for obvious reasons.

Package naming explained:
[Target]-gcc-[Version]-release-[OS]-rubenvb.*

Target:  GCC triplet for the system this toolchain builds code for:
         x86_64-w64-mingw32: 64-bit Windows
         i686-w64-mingw32: 32-bit Windows
Version: GCC version
OS:      OS the toolchain is built for:
         linux: 64-bit linux
         win64: 64-bit Windows
         win32: 32-bit Windows (also work on 64-bit Windows)

You need an archive program like 7-zip (www.7-zip.org) to unpack these packages.
