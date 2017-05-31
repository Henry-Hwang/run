#!/bin/sh

grep '#define CSPL_CONFIG_' $1 | awk '
BEGIN {FS=", | "}
{for (i=3; i <= NF; i++) {printf("%d\n",$i)}}
' | perl -pe '$_ = pack("l", $_)' > temp.bin
adb push temp.bin data/cspl_configs.bin
rm temp.bin
