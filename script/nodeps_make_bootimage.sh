#!/bin/bash
DIR_ROOT=/opt/ubt-work/src/customer/meizu/x30-l2
PROJECT=mz6799_6m_v2_n
DIR_KERNEL=kernel-4.4

echo "============================================================"
echo "Notice:"
echo "1. Put this script in Android root directory"
echo "2. Make sure that you have set DIR_ROOT, DIR_KERNEL, PROJECT"
echo "============================================================"

mkdir -p $DIR_ROOT/out/target/product/$PROJECT/obj/KERNEL_OBJ
make -j24 -C $DIR_KERNEL O=$DIR_ROOT/out/target/product/$PROJECT/obj/KERNEL_OBJ ARCH=arm64 CROSS_COMPILE=/$DIR_ROOT/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- ROOTDIR=$DIR_ROOT GOODIX_FP_BIO_SUPPORT=
out/host/linux-x86/bin/acp -fp $DIR_ROOT/out/target/product/$PROJECT/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb $DIR_ROOT/out/target/product/$PROJECT/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb.bin
out/host/linux-x86/bin/acp -fp $DIR_ROOT/out/target/product/$PROJECT/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb.bin out/target/product/$PROJECT/kernel

#this command line equals to "make bootimage-nodeps"
out/host/linux-x86/bin/mkbootimg  --kernel out/target/product/$PROJECT/kernel --ramdisk out/target/product/$PROJECT/ramdisk.img --cmdline \"bootopt=64S3,32N2,64N2\" --base 0x40000000 --ramdisk_offset 0x05000000 --kernel_offset 0x00080000 --tags_offset 0x4000000 --board 1494464891 --os_version 7.0 --os_patch_level 2017-04-05 --kernel_offset 0x00080000 --ramdisk_offset 0x05000000 --tags_offset 0x4000000 --output out/target/product/$PROJECT/boot.img
