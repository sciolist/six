V=3.6.1

set -e
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WORKING_DIR && cd $WORKING_DIR

if [ ! -d linux-$V ]; then
  if [ ! -f linux-$V.tar.bz2 ]; then
    wget http://www.kernel.org/pub/linux/kernel/v3.0/linux-$V.tar.bz2
  fi
  tar -xvjf linux-$V.tar.bz2
fi

ARCH=$A
[ "$ARCH" = "i686" ] && ARCH=i386
export ARCH

cd linux-$V
export CROSS_COMPILE="$ARCH-unknown-linux-musl-"
make allnoconfig KCONFIG_ALLCONFIG="$ROOT/config/linux.config"
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
mkdir -p "$OUT"/$A-unknown-linux-musl/include/
cp -rv dest/include/* "$OUT"/$A-unknown-linux-musl/include/

