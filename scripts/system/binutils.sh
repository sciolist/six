#!/bin/bash -e
source $(cd $( dirname "$0" ) && pwd)/../shared.sh
is_done && exit 0
V=$BINUTILS_VERSION
URL="http://ftp.gnu.org/gnu/binutils/binutils-$V.tar.gz"
cd $WRK

test -f $DL/binutils-$V.tar.gz || wget $URL -O $DL/binutils-$V.tar.gz
tar -xf $DL/binutils-$V.tar.gz

CFLAGS="$CFLAGS -ffunction-sections -fdata-sections"
LDFLAGS="$LDFLAGS -Wl,--gc-sections"

cd binutils-$V
sed -e 's/uclibc/musl/g' config.sub > config.sub.tmp && mv config.sub.tmp config.sub
./configure --prefix=/ --host=$A-unknown-linux-musl \
  --target=$A-unknown-linux-musl \
  --disable-werror --disable-shared --disable-nls --disable-install-libbfd

make
make install-gas install-ld install-binutils DESTDIR="$OUT"
rm -rf "$OUT/$A-unknown-linux-musl/"
mark_done
