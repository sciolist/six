#!/bin/bash -e
source $(cd $( dirname "$0" ) && pwd)/../shared.sh
is_done && exit 0
cd $WRK

for i in etc proc dev sys root mnt tmp;do
  mkdir -p "$OUT/$i"
done

if [ -d "$OUT/sbin" ];then
  mv "$OUT/sbin/*" "$OUT/bin"
  rmdir "$OUT/sbin"
  ln -s bin "$OUT/sbin"
fi

test "$OUT/usr" || ln -sf / "$OUT/usr"
cp -r $SRC/fs/* $OUT
mark_done

