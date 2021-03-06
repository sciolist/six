#!/bin/bash -e
source $(cd $( dirname "$0" ) && pwd)/../shared.sh
is_done && exit 0
V=$BUSYBOX_VERSION
cd $WRK

test  -f $DL/busybox-$V.tar.bz2 || wget http://busybox.net/downloads/busybox-$V.tar.bz2 -O $DL/busybox-$V.tar.bz2
tar -xjf $DL/busybox-$V.tar.bz2

cd busybox-$V
patch -N -p1 < $SRC/patches/busybox.patch 
export CROSS_COMPILE="$A-unknown-linux-musl-"
make allnoconfig KCONFIG_ALLCONFIG="$ROOT/config/busybox.config"
make
make busybox.links
mkdir -p "$OUT"/bin
cp busybox "$OUT"/bin/busybox

cat busybox.links | while read line;do
  ln -sf busybox "$OUT"/bin/"$(basename $line)"
done
mark_done

