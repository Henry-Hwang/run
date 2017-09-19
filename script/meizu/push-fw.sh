#!/bin/bash
# PROJECT: M1781/M1881
# LOCATE: amss/ADSP.VT.4.0/adsp_proc/
# FOUCTION: push adsp image to file system
# RUN: ./push-fw.sh

adb wait-for-device
adb root 
adb remount 
adb shell "umount /firmware/"
adb shell "mount -o rw /dev/block/bootdevice/by-name/modem /firmware"
adb shell "rm /firmware/image/adsp.*"
adb shell "rm /persist/sensors/sns.reg"
#adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b00  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b01  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b02  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b03  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b04  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b05  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b06  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b07  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b08  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b09  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b10  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b11  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b12  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b13  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b14  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b15  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b16  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b17  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b18  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b19  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b20  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b21  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.b22  /firmware/image/
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/adsp.mdt  /firmware/image/

adb shell "ls -l /firmware/image/ | grep adsp"
adb shell sync
sleep 1
adb shell
#adb reboot
