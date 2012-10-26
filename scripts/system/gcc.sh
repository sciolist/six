#!/bin/sh -e
V=4.2.1
SRC=$( cd "$( dirname "$0" )" && pwd )
cd $WRK

test  -f $DL/gcc-core-$V.tar.bz2 || wget http://ftp.gnu.org/gnu/gcc/gcc-$V/gcc-core-$V.tar.bz2 -O $DL/gcc-core-$V.tar.bz2
tar -xjf $DL/gcc-core-$V.tar.bz2

cd gcc-$V
patch -N -p1 < $SRC/patches/gcc.patch
for i in strsignal putenv random setenv strstr strtod strtol strtoul;do
  culprit=libiberty/$i.c
  rm $culprit
  touch $culprit
done

./configure --prefix=/ --host=$A-unknown-linux-musl --target=$A-unknown-linux-musl \
            --build=$A-unknown-linux --enable-languages=c \
            --disable-libmudflap --disable-shared --disable-nls \
            --disable-bootstrap --disable-libgomp --disable-tls --with-newlib
make all-gcc
make install-gcc DESTDIR="$OUT"

