V=3.6.1
set -e
SRC=$( cd "$( dirname "$0" )" && pwd )
mkdir -p $WRK && cd $WRK

if [ ! -d linux-$V ]; then
  test -f linux-$V.tar.bz2 || wget http://www.kernel.org/pub/linux/kernel/v3.0/linux-$V.tar.bz2
  tar -xjf linux-$V.tar.bz2
fi

export CROSS_COMPILE="$A-unknown-linux-musl-"
ARCH=$A
[ "$ARCH" = "i686" ] && ARCH=i386
export ARCH

cd linux-$V
make allnoconfig KCONFIG_ALLCONFIG="$ROOT/config/linux.config"
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
mkdir -p "$OUT"/$A-unknown-linux-musl/include/
cp -rv dest/include/* "$OUT"/$A-unknown-linux-musl/include/

