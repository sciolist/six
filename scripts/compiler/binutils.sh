V=397a64b3
set -e
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d binutils-$V ]; then
  test -f binutils-$V.tar.bz2 || wget http://landley.net/aboriginal/mirror/binutils-$V.tar.bz2
  tar -xjf binutils-$V.tar.bz2
fi
patch -N -d binutils-$V -p1 < $SRC/patches/binutils.patch || true

cd binutils-$V
./configure --target=$A-unknown-linux-musl --prefix="$OUT" \
            --disable-install-libbfd --disable-werror
make
make install-gas install-ld install-binutils

