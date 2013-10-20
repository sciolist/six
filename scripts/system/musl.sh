#!/bin/bash -e
source $(cd $( dirname "$0" ) && pwd)/../shared.sh
is_done && exit 0
V=$MUSL_VERSION
cd $WRK

test  -f $DL/musl-$V.tar.bz2 || wget http://www.etalabs.net/musl/releases/musl-$V.tar.gz -O $DL/musl-$V.tar.bz2
tar -xzf $DL/musl-$V.tar.gz

cd musl-$V
./configure --prefix=/ --host=$A-unknown-linux-musl \
            --target=$A-unknown-linux-musl --disable-gcc-wrapper
        
make
make DESTDIR="$OUT" install
mark_done

