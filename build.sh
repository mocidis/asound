#!/bin/bash
if [ $# -lt 1 ]; then
echo "
Usage:
    ./build.sh [0|1]
        0: don't do cross compile for arm
        1: do cross compile for arm
"
exit
fi
#define constant variable
LINUX_ARMV7L=$PWD/../libs/linux-armv7l
LINUX_X86_64=$PWD/../libs/linux-x86_64
LINUX_I686=$PWD/../libs/linux-i686
MINGW=$PWD/../libs/mingw32-i586
MACOS=$PWD/../libs/darwin-x86_64
ARM=$1
#MACOS
uname -a | grep "Darwin"
if [ $? == 0 ]; then
	INSTALL_DIR=$MACOS
fi
#MINGW
uname -a | grep "MINGW32"
if [ $? == 0 ]; then
	INSTALL_DIR=$MINGW
fi
#Linux
uname -a | grep "Linux"
if [ $? == 0 ]; then
	ARCHITECTURE=`uname -m`
	if [ $ARCHITECTURE = "i686" ]; then
		INSTALL_DIR=$LINUX_I686
	elif [ $ARCHITECTURE = "x86_64" ]; then
		INSTALL_DIR=$LINUX_X86_64
	fi
fi

echo $INSTALL_DIR
#build for arm first
if [ $ARM == 1 ]; then
	make distclean
	./configure --host=arm-linux --disable-python --prefix=$LINUX_ARMV7L CC=arm-none-linux-gnueabi-gcc
	make -j4
	make install
fi
#build for intel
make distclean
./configure --disable-python --prefix=$INSTALL_DIR
make -j4
make install
