#!/bin/sh -e
V=$LINUX_VERSION
SRC=$( cd "$( dirname "$0" )" && pwd )
cd $WRK

test  -f $DL/linux-$V.tar.bz2 || wget http://www.kernel.org/pub/linux/kernel/v3.0/linux-$V.tar.bz2 -O $DL/linux-$V.tar.bz2
tar -xjf $DL/linux-$V.tar.bz2

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

