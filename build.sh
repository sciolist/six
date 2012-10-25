PATH=$PATH:$(pwd)
export A=$(uname -m)
export ROOT=$(pwd)
export WORKING_DIR=$ROOT/_work
export COMPILER_PREFIX=$ROOT/_work/compiler
export CC="$A-unknown-linux-musl-gcc"
export CFLAGS="-Os"
export LDFLAGS="-s"

mkdir -p $(COMPILER_PREFIX)
sh scripts/compiler/binutils.sh
sh scripts/compiler/gcc.sh
sh scripts/compiler/linux-headers.sh

ls

