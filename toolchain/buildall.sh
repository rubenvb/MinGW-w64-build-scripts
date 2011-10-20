#!/usr/bin/env bash
set -e

. ./buildlinux64mingw32.sh || exit 1
. ./buildlinux64mingw64.sh || exit 1
#. ./buildlinux32mingw32.sh || exit 1
#. ./buildlinux32mingw64.sh || exit 1

export PATH=$PWD/linux64mingw32/mingw32/bin:$PWD/linux64mingw64/mingw64/bin:$PATH

. ./buildmingw64mingw64.sh || exit 1
. ./buildmingw32mingw32.sh || exit 1
#. ./buildmingw32mingw64.sh || exit 1
#. ./buildmingw64mingw32.sh || exit 1

. ./buildmac32mingw32.sh || exit 1
. ./buildmac32mingw64.sh || exit 1
#. ./buildmac64mingw32.sh || exit 1
#. ./buildmac64mingw64.sh || exit 1

. ./buildcygwin32mingw32.sh || exit 1
. ./buildcygwin32mingw64.sh || exit 1

