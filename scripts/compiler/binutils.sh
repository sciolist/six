#!/bin/sh -e
V=397a64b3
SRC=$( cd "$( dirname "$0" )" && pwd )
cd $WRK

test  -f $DL/binutils-$V.tar.bz2 || wget http://landley.net/aboriginal/mirror/binutils-$V.tar.bz2 -O $DL/binutils-$V.tar.bz2
tar -xjf $DL/binutils-$V.tar.bz2

cd binutils-$V
patch -N -p1 < $SRC/patches/binutils.patch 
./configure --target=$A-unknown-linux-musl --prefix="$OUT" \
            --disable-install-libbfd --disable-werror
make
make install-gas install-ld install-binutils

