V=397a64b3
set -e
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WORKING_DIR
cd $WORKING_DIR

CFLAGS="$CFLAGS -ffunction-sections -fdata-sections"
LDFLAGS="$LDFLAGS -Wl,--gc-sections"
config_options="--disable-werror --disable-shared --disable-nls --disable-install-libbfd"

if [ ! -d binutils-$V ]; then
  if [ ! -f binutils-$V.tar.bz2 ]; then
    wget http://landley.net/aboriginal/mirror/binutils-$V.tar.bz2
  fi
  tar -xvjf binutils-$V.tar.bz2
fi
patch -t -d binutils-$V -p1 < $SRC/patches/binutils.patch 

cd binutils-$V
./configure --prefix=/ --host=$A-unknown-linux-musl \
            --target=$A-unknown-linux-musl $config_options

make
make install-gas install-ld install-binutils DESTDIR="$OUT"

