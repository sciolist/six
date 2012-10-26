#!/bin/sh -e
V=0.9.6
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d musl-$V ]; then
  test -f musl-$V.tar.bz2 || wget http://www.etalabs.net/musl/releases/musl-$V.tar.gz
  tar -xzf musl-$V.tar.gz
fi

cd musl-$V
./configure --prefix=/ --host=$A-unknown-linux-musl \
            --target=$A-unknown-linux-musl --disable-gcc-wrapper
        
make
make DESTDIR="$OUT" install

