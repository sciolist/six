#!/bin/sh -e
V=397a64b3
SRC=$( cd "$( dirname "$0" )" && pwd )
cd $WRK

test  -f $DL/binutils-$V.tar.bz2 || wget http://landley.net/aboriginal/mirror/binutils-$V.tar.bz2 -O $DL/binutils-$V.tar.bz2
tar -xjf $DL/binutils-$V.tar.bz2

CFLAGS="$CFLAGS -ffunction-sections -fdata-sections"
LDFLAGS="$LDFLAGS -Wl,--gc-sections"

cd binutils-$V
patch -N -p1 < $SRC/patches/binutils.patch 
./configure --prefix=/ --host=$A-unknown-linux-musl \
  --target=$A-unknown-linux-musl \
  --disable-werror --disable-shared --disable-nls --disable-install-libbfd

make
make install-gas install-ld install-binutils DESTDIR="$OUT"
rm -rf "$OUT/$A-unknown-linux-musl/"

