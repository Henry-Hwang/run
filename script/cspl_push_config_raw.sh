#!/bin/sh

echo | cat $1 - $2 | awk '
BEGIN {FS=", | "}
{for (i=1; i <= NF; i++) {printf("%d\n",$i)}}
' | perl -pe '$_ = pack("l", $_)' > temp.bin

adb wait-for-device
adb remount
sleep 1
adb push temp.bin data/cspl_configs.bin
rm temp.bin
