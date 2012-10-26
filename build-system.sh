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

#./scripts/system/musl.sh
#./scripts/system/binutils.sh
#./scripts/system/gcc.sh
#./scripts/system/make.sh
#./scripts/system/busybox.sh
./scripts/system/linux.sh

