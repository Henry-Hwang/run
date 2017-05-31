#!/bin/sh
adb wait-for-device
dir="am start -n com.android.music/com.android.music.MediaPlaybackActivity -d /sdcard/Music/"
if [ $1 = "stop" ];then
   adb shell 'am force-stop com.android.music'
elif [ $1 = "ls" ];then
	adb shell 'ls -l /sdcard/Music'
	adb shell 'ls -l /sdcard/Music/cirrus'
else
	
	adb shell $dir$1
fi

