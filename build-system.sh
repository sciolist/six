#!/bin/sh -e
export A=$(uname -m)
export ROOT=$(pwd)
export DL=$ROOT/_work/download
export WRK=$ROOT/_work/system
export OUT=$ROOT/out/system
export PATH=$ROOT/out/compiler/bin:$PATH
export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"
rm -rf $WRK
mkdir -p $OUT && mkdir -p $WRK && mkdir -p $DL

./scripts/system/musl.sh
./scripts/system/binutils.sh
./scripts/system/gcc.sh
./scripts/system/make.sh
./scripts/system/busybox.sh
./scripts/system/linux.sh
./scripts/system/setup.sh

