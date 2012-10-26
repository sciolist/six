#!/bin/sh -e
cd $WRK

for i in etc proc dev sys root mnt tmp;do
  mkdir -p "$OUT/$i"
done

if [ -d "$OUT/sbin" ];then
  mv "$OUT/sbin/*" "$OUT/bin"
  rmdir "$OUT/sbin"
  ln -s bin "$OUT/sbin"
fi

ln -sf / "$OUT/usr"
cp -r $SRC/fs $OUT
chmod +x "$out"/etc/rc

