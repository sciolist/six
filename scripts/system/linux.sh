#!/bin/sh -e
V=3.6.1
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d linux-$V ]; then
  test -f linux-$V.tar.bz2 || wget http://www.kernel.org/pub/linux/kernel/v3.0/linux-$V.tar.bz2
  tar -xjf linux-$V.tar.bz2
  #patch -N -d linux-$V -p1 < $SRC/patches/linux.patch 
fi

export CROSS_COMPILE="$A-unknown-linux-musl-"
ARCH=$A
IMAGE=$ARCH
[ "$ARCH" = "i686"  ] && ARCH=i386
[ "$ARCH" = "i386"  ] && IMAGE=x86
[ "$ARCH" = "x86_64"] && IMAGE=x86
export ARCH

cd linux-$V
make allnoconfig KCONFIG_ALLCONFIG="$ROOT/config/linux.config"
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete

make
mkdir -p "$OUT/boot"
cp System.map "$OUT/boot"
cp arch/$IMAGE/boot/bzImage "$OUT/boot/vmlinuz-$V"

make INSTALL_MOD_PATH="$OUT" modules_install

mkdir -p "$OUT/include/"
cp -rv dest/include/* "$OUT/include/"
