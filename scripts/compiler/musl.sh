#!/bin/bash -e
source $(cd $( dirname "$0" ) && pwd)/../shared.sh
is_done && exit 0
V=$MUSL_VERSION
cd $WRK

test  -f $DL/musl-$V.tar.gz || wget http://www.etalabs.net/musl/releases/musl-$V.tar.gz -O $DL/musl-$V.tar.gz
tar -xzf $DL/musl-$V.tar.gz

export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"

cd musl-$V
./configure --host=$A-unknown-linux-musl --prefix="$OUT"/$A-unknown-linux-musl/ \
            --syslibdir="$OUT"/lib --disable-gcc-wrapper --disable-shared
make
make install
mark_done
