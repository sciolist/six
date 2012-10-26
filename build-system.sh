set -e
export A=$(uname -m)
export ROOT=$(pwd)
export WRK=$ROOT/_work/_system
export OUT=$ROOT/_work/system
export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"
export PATH=$ROOT/_work/compiler/bin:$PATH
mkdir -p $OUT

sh scripts/system/musl.sh
sh scripts/system/binutils.sh

