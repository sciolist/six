set -e
export SRC=$(cd $(dirname "$0") && pwd)
export NAME=$(basename "$0")
export MODE=$(basename "$SRC")
export ROOT=$(dirname $(dirname "$SRC"))
export DL=$ROOT/_work/download
export WRK=$ROOT/_work/$MODE
export OUT=$ROOT/out/$MODE
export A=$(uname -m)
export PATH=$ROOT/out/compiler/bin:$PATH
mkdir -p $OUT && mkdir -p $WRK && mkdir -p $DL
source $ROOT/versions.sh

function is_done { test -f $WRK/$NAME.done; }
function mark_done { touch $WRK/$NAME.done; }
echo "## BUILDING $MODE - $NAME" 

if [ "$MODE" = "compiler" ]; then
else
  export CC="$A-unknown-linux-musl-gcc"
  export CFLAGS="-Os"
  export LDFLAGS="-s"
fi



