#!/bin/sh -e
V=0.9.6
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d musl-$V ]; then
  test -f musl-$V.tar.bz2 ] || wget http://www.etalabs.net/musl/releases/musl-$V.tar.gz
  tar -xzf musl-$V.tar.gz
fi

cd musl-$V
./configure --host=$A-unknown-linux-musl --prefix="$OUT"/$A-unknown-linux-musl/ \
            --syslibdir="$OUT"/lib --disable-gcc-wrapper --disable-shared
make
make install

