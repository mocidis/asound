#!/bin/bash
#build for arm first
./configure --host=arm-linux --disable-python CC=arm-none-linux-gnueabi-gcc
make -j4
make install DESTDIR=$PWD/output.arm

#build for intel
make distclean
./configure --disable-python
make -j4
make install DESTDIR=$PWD/output.intel
