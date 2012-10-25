V=4.2.1

set -e
SRC=$(pwd)
mkdir -p $WORKING_DIR
cd $WORKING_DIR

if [ ! -d gcc-$V ]; then
  if [ ! -f gcc-core-$V.tar.bz2 ]; then
    wget http://ftp.gnu.org/gnu/gcc/gcc-$V/gcc-core-$V.tar.bz2
  fi
  tar -xvjf gcc-core-$V.tar.bz2
  patch -d gcc-$V -p1 < $SRC/patches/gcc.patch
fi

cd gcc-$V
rm -rf ./gcc-build
mkdir -p gcc-build
cd gcc-build
../configure --target=$A-unknown-linux-musl --enable-languages=c \
      --with-newlib --disable-multilib --disable-libssp --disable-libquadmath \
      --disable-threads --disable-decimal-float --disable-shared --disable-libmudflap \
      --disable-libgomp --disable-tls --prefix="$COMPILER_PREFIX"

make all-gcc
make install-gcc

