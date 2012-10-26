#!/bin/sh -e
V=397a64b3
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d binutils-$V ]; then
  test -f binutils-$V.tar.bz2 || wget http://landley.net/aboriginal/mirror/binutils-$V.tar.bz2
  tar -xjf binutils-$V.tar.bz2
  patch -N -d binutils-$V -p1 < $SRC/patches/binutils.patch 
fi

CFLAGS="$CFLAGS -ffunction-sections -fdata-sections"
LDFLAGS="$LDFLAGS -Wl,--gc-sections"

cd binutils-$V
./configure --disable-werror --disable-shared --disable-nls --disable-install-libbfd \
            --prefix=/ --host=$A-unknown-linux-musl \
            --target=$A-unknown-linux-musl

make
make install-gas install-ld install-binutils DESTDIR="$OUT"

