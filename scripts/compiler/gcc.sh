#!/bin/sh -e
V=4.2.1
SRC=$( cd "$( dirname "$0" )" && pwd )
cd $WRK

test  -f $DL/gcc-core-$V.tar.bz2 || wget http://ftp.gnu.org/gnu/gcc/gcc-$V/gcc-core-$V.tar.bz2 -O $DL/gcc-core-$V.tar.bz2
tar -xjf $DL/gcc-core-$V.tar.bz2

cd gcc-$V
patch -N -p1 < $SRC/patches/gcc.patch 
rm -rf ./gcc-build
mkdir -p gcc-build
cd gcc-build
../configure --target=$A-unknown-linux-musl --enable-languages=c \
      --with-newlib --disable-multilib --disable-libssp --disable-libquadmath \
      --disable-threads --disable-decimal-float --disable-shared --disable-libmudflap \
      --disable-libgomp --disable-tls --prefix="$OUT"

make all-gcc
make install-gcc

cd ..
rm -rf ./gcc-build
TARGET=$(dirname $($A-unknown-linux-musl-gcc -print-libgcc-file-name))
echo " >> >> $TARGET"
mkdir -p $TARGET
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > "$TARGET"/include/limits.h

