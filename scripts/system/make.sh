#!/bin/bash -e
source $(cd $( dirname "$0" ) && pwd)/../shared.sh
is_done && exit 0
V=$MAKE_VERSION
cd $WRK

test  -f $DL/make-$V.tar.bz2 || wget http://ftp.gnu.org/gnu/make/make-$V.tar.bz2 -O $DL/make-$V.tar.bz2
tar -xjf $DL/make-$V.tar.bz2

cd make-$V
patch -N -p1 < $SRC/patches/make.patch 
config_sub=config/config.sub
./configure --prefix=/ --host=$A-unknown-linux-musl \
            --target=$A-unknown-linux-musl --disable-nls
        
make
make DESTDIR="$OUT" install
mark_done

