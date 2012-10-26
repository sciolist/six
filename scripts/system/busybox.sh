#!/bin/sh -e
V=1.20.2
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d busybox-$V ]; then
  test -f busybox-$V.tar.bz2 || wget http://busybox.net/downloads/busybox-$V.tar.bz2
  tar -xjf busybox-$V.tar.bz2
  patch -N -d busybox-$V -p1 < $SRC/patches/busybox.patch 
fi

cd busybox-$V
export CROSS_COMPILE="$A-unknown-linux-musl-"
make allnoconfig KCONFIG_ALLCONFIG="$ROOT/config/busybox.config"
make
make busybox.links
mkdir -p "$OUT"/bin
cp busybox "$OUT"/bin/busybox

cat busybox.links | while read line;do
  ln -sf busybox "$OUT"/bin/"$(basename $line)"
done

