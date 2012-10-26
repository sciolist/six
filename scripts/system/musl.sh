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
./configure --prefix=/ --host=$A-unknown-linux-musl \
            --target=$A-unknown-linux-musl --disable-gcc-wrapper
        
make
make DESTDIR="$OUT" install

