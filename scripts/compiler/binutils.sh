V=397a64b3

set -e
SRC=$(pwd)
mkdir -p $WORKING_DIR
cd $WORKING_DIR

if [ ! -d binutils-$V ]; then
  if [ ! -f binutils-$V.tar.bz2 ]; then
    wget http://landley.net/aboriginal/mirror/binutils-$V.tar.bz2
  fi
  tar -xvjf binutils-$V.tar.bz2
  patch -d binutils-$V -p1 < $SRC/patches/binutils.patch 
fi

cd binutils-$V
./configure --target=$A-unknown-linux-musl --prefix="$COMPILER_PREFIX" --disable-install-libbfd --disable-werror
make
make install-gas install-ld install-binutils

