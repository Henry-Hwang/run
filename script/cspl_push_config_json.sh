#!/bin/sh

grep '"config":' $1 | awk '
BEGIN {FS=":|\"|, "}
{for (i=5; i <= NF-2; i++) {printf("%d\n",$i)}}
' | perl -pe '$_ = pack("l", $_)' > temp.bin
adb push temp.bin data/cspl_configs.bin
rm temp.bin
