#!/bin/sh
set -e
export A=$(uname -m)
export ROOT=$(pwd)
export WRK=$ROOT/_work/_compiler
export OUT=$ROOT/_work/compiler
PATH=$ROOT/_work/compiler/bin:$PATH
mkdir -p $OUT

sh scripts/compiler/binutils.sh
sh scripts/compiler/gcc.sh

PATH=$OUT/bin:$PATH
export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"

sh scripts/compiler/linux-headers.sh
sh scripts/compiler/musl.sh

