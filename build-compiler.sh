#!/bin/sh -e
export A=$(uname -m)
export ROOT=$(pwd)
export DL=$ROOT/_work/download
export WRK=$ROOT/_work/compiler
export OUT=$ROOT/out/compiler
export PATH=$ROOT/out/compiler/bin:$PATH
rm -rf $WRK
mkdir -p $OUT && mkdir -p $WRK && mkdir -p $DL

./scripts/compiler/binutils.sh
exit 321
./scripts/compiler/gcc.sh

export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"

./scripts/compiler/linux-headers.sh
./scripts/compiler/musl.sh

