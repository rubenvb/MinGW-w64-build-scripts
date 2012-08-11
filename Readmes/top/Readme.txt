Welcome to the rubenvb MinGW-w64 download section.

You will find the latest MinGW-w64 GCC toolchains here, which include:
 - GCC: compiler for (obj-)c(++), and fortran
 - binutils: linker and object file inspection
 - gdb: debugger
 - Clang: works great for 32-bit, aside from some minor DLL-related issues.

There are packages for each release of GCC, from 4.5 to the current release.
The latest release version is always recommended.

Experimental packages provide certain features not yet considered stable, as
a preview.

What do you need to download?
Packages are named as follows:

    [Target]-gcc-[Version]-release-[OS]-rubenvb.*
    [Target]-clang-[Version]-release-[OS]-rubenvb.*

Target:  GCC triplet for the system this toolchain builds code for:
         x86_64-w64-mingw32: 64-bit Windows
         i686-w64-mingw32: 32-bit Windows
Version: GCC version
OS:      OS the toolchain is built for:
         linux64: 64-bit linux
         win64: 64-bit Windows
         win32: 32-bit Windows (also work on 64-bit Windows)
         cygwin: Cygwin (www.cygwin.com)

You need an archive program like 7-zip (www.7-zip.org) to unpack these packages.
