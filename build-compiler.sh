#!/bin/sh
set -e
export A=$(uname -m)
export ROOT=$(pwd)
export WRK=$ROOT/_work/_compiler
export OUT=$ROOT/_work/compiler
PATH=$ROOT/_work/compiler/bin:$PATH
mkdir -p $OUT

./scripts/compiler/binutils.sh
./scripts/compiler/gcc.sh

export PATH=$OUT/bin:$PATH
export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"

./scripts/compiler/linux-headers.sh
./scripts/compiler/musl.sh

