V=3.6.1

set -e
SRC=$(pwd)
mkdir -p $WORKING_DIR
cd $WORKING_DIR

if [ ! -d linux-$V ]; then
  if [ ! -f linux-$V.tar.bz2 ]; then
    wget http://www.kernel.org/pub/linux/kernel/v3.0/linux-$V.tar.bz2
  fi
  tar -xvjf linux-$V.tar.bz2
  #patch -d gcc-$V -p1 < $SRC/patches/gcc.patch
fi

ARCH=$A
[ "$ARCH" = "i686" ] && ARCH=i386
export ARCH

cd linux-$V
export CROSS_COMPILE="$ARCH-unknown-linux-musl-"
make allnoconfig KCONFIG_ALLCONFIG="$ROOT/config/linux.config"
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
mkdir -p "$COMPILER_PREFIX"/$A-unknown-linux-musl/include/
cp -rv dest/include/* "$COMPILER_PREFIX"/$A-unknown-linux-musl/include/

return
name=linux

url=http://www.kernel.org/pub/linux/kernel/v3.0/linux-$version.tar.bz2

out=$top/cross

patches=linux-noperl-headers.patch

export CROSS_COMPILE="$A-unknown-linux-musl-"
ARCH=$A
[ "$ARCH" = "i686" ] && ARCH=i386
export ARCH

config() {
	make allnoconfig KCONFIG_ALLCONFIG="$top/linux.config"
}

build() {
	make INSTALL_HDR_PATH=dest headers_install
}

install() {
	find dest/include \( -name .install -o -name ..install.cmd \) -delete
	mkdir -p "$out"/$A-unknown-linux-musl/include/
	cp -rv dest/include/* "$out"/$A-unknown-linux-musl/include/
}

