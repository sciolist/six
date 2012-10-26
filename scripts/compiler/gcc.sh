V=4.2.1
set -e
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d gcc-$V ]; then
  test -f gcc-core-$V.tar.bz2 || wget http://ftp.gnu.org/gnu/gcc/gcc-$V/gcc-core-$V.tar.bz2
  tar -xjf gcc-core-$V.tar.bz2
fi
patch -N -d gcc-$V -p1 < $SRC/patches/gcc.patch || true

cd gcc-$V
rm -rf ./gcc-build
mkdir -p gcc-build
cd gcc-build
../configure --target=$A-unknown-linux-musl --enable-languages=c \
      --with-newlib --disable-multilib --disable-libssp --disable-libquadmath \
      --disable-threads --disable-decimal-float --disable-shared --disable-libmudflap \
      --disable-libgomp --disable-tls --prefix="$OUT"

make all-gcc
make install-gcc

cd ..
rm -rf ./gcc-build
TARGET=$(dirname $($A-unknown-linux-musl-gcc -print-libgcc-file-name))
echo " >> >> $TARGET"
mkdir -p $TARGET
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > "$TARGET"/include/limits.h

