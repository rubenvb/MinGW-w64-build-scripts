#!/usr/bin/env bash
set -e

sh ./buildlinux64mingw32.sh || exit 1
sh ./buildlinux64mingw64.sh || exit 1
#sh ./buildlinux32mingw32.sh || exit 1
#sh ./buildlinux32mingw64.sh || exit 1

export PATH=$PWD/linux64mingw32/mingw32/bin:$PWD/linux64mingw64/mingw64/bin:$PATH

sh ./buildmingw64mingw64.sh || exit 1
sh ./buildmingw32mingw32.sh || exit 1
#sh ./buildmingw32mingw64.sh || exit 1
#sh ./buildmingw64mingw32.sh || exit 1

sh ./buildmac32mingw32.sh || exit 1
sh ./buildmac32mingw64.sh || exit 1
#sh ./buildmac64mingw32.sh || exit 1
#sh ./buildmac64mingw64.sh || exit 1

sh ./buildcygwin32mingw32.sh || exit 1
sh ./buildcygwin32mingw64.sh || exit 1

