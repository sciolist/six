#!/bin/sh -e
V=0.9.6
SRC=$( cd "$( dirname "$0" )" && pwd )
cd $WRK

test  -f $DL/musl-$V.tar.gz || wget http://www.etalabs.net/musl/releases/musl-$V.tar.gz -O $DL/musl-$V.tar.gz
tar -xzf $DL/musl-$V.tar.gz

cd musl-$V
./configure --host=$A-unknown-linux-musl --prefix="$OUT"/$A-unknown-linux-musl/ \
            --syslibdir="$OUT"/lib --disable-gcc-wrapper --disable-shared
make
make install

