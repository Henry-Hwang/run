#!/bin/bash
adb wait-for-device
adb root
sleep 1
adb remount
adb push out/target/product/sdm660_64/system/bin/cirrus_sp /system/bin
adb push out/target/product/sdm660_64/system/lib/hw/audio.primary.sdm660.so 	/system/lib/hw/
adb push out/target/product/sdm660_64/system/lib64/hw/audio.primary.sdm660.so 	/system/lib64/hw/
adb push hardware/qcom/audio/configs/sdm660/mixer_paths.xml /etc/
adb push hardware/qcom/audio/configs/sdm660/audio_platform_info.xml /etc/
#adb reboot