set -e
export A=$(uname -m)
export ROOT=$(pwd)
export WORKING_DIR=$ROOT/_work/_system
export OUT=$ROOT/_work/system
mkdir -p $OUT

PATH=$ROOT/_work/compiler/bin:$PATH
export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"

sh scripts/system/musl.sh
sh scripts/system/binutils.sh

