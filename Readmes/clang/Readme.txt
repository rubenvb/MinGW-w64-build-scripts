Here you will find the latest Clang compiler releases.

Currently, it is a functional compiler for 32-bit for C and C++.
Clang is currently made to function with the gcc-dw2-4.6* package.
I also provide 64-bit builds, but these are only useful for C.
Compiling C++ to 64-bit object code will result in linker errors.
You can still use if for its better diagnostics and static analysis.

To use it, you should extract the Clang package in the same directory
as the gcc-dw2 package, do that the ddirectories overlap. This ensures
the C and C++ headers are found by Clang.

To use clang, just replace "gcc" with "clang" and "g++" and "clang++".
Clang currently imitates GCC as a frontend, and all options GCC accepts,
Clang accepts. Some options that are unsupported by Clang are ignored.

Some DLL-related issues remain, reporting these (if not done so already)
to me or the LLVM bugtracker will help identifying and eventually fixing
them.
