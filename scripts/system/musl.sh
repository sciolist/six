#!/bin/sh -e
V=0.9.6
SRC=$( cd "$( dirname "$0" )" && pwd )
cd $WRK

test  -f $DL/musl-$V.tar.bz2 || wget http://www.etalabs.net/musl/releases/musl-$V.tar.gz -O $DL/musl-$V.tar.bz2
tar -xzf $DL/musl-$V.tar.gz

cd musl-$V
./configure --prefix=/ --host=$A-unknown-linux-musl \
            --target=$A-unknown-linux-musl --disable-gcc-wrapper
        
make
make DESTDIR="$OUT" install

