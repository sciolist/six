V=0.9.6

set -e
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WORKING_DIR && cd $WORKING_DIR

if [ ! -d musl-$V ]; then
  if [ ! -f musl-$V.tar.bz2 ]; then
    wget http://www.etalabs.net/musl/releases/musl-$V.tar.gz
  fi
  tar -xvzf musl-$V.tar.gz
fi

cd musl-$V
./configure --host=$A-unknown-linux-musl --prefix="$OUT"/$A-unknown-linux-musl/ \
            --syslibdir="$OUT"/lib --disable-gcc-wrapper --disable-shared
make
make install
