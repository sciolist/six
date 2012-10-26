#!/bin/sh -e
V=3.82
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d make-$V ]; then
  test -f make-$V.tar.bz2 || wget http://ftp.gnu.org/gnu/make/make-$V.tar.bz2
  tar -xjf make-$V.tar.bz2
  patch -N -d make-$V -p1 < $SRC/patches/make.patch 
fi

cd make-$V
config_sub=config/config.sub
./configure --prefix=/ --host=$A-unknown-linux-musl \
            --target=$A-unknown-linux-musl --disable-nls
        
make
make DESTDIR="$OUT" install

