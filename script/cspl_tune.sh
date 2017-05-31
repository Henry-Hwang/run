#!/bin/bash

adb wait-for-device
adb remount

function switch_config()
{
	#switch to config
	adb shell "cspl_control 5"
	sleep 1
}
function cal_read ()
{
	adb shell "cspl_control 4 18500 24 0.0033 10 2000"
}
function playback()
{
	#playback
	adb shell 'am start -n com.android.music/com.android.music.MediaPlaybackActivity -d /sdcard/Music/cirrus/Mercy-On-Me.wav'
	#make sure 16dB
	adb shell "echo 19 11 > /d/regmap/0-0040/registers"
}
function stop_music()
{
	echo "stop music"
	adb shell 'am force-stop com.android.music'
}
function calibration()
{
	#calibration
	adb shell 'cspl_control -v'
	adb shell 'cspl_control 1'
	stop_music
	echo "start music"
	adb shell 'am start -n com.android.music/com.android.music.MediaPlaybackActivity -d /sdcard/Music/cirrus/Mercy-On-Me.wav'
	sleep 2.5
	stop_music
	sleep 3.5
	adb shell 'cspl_control 2 25'
	sleep 1.5
	adb shell 'cspl_control 3'
}

function push_tuning()
{
	echo | cat $1 - $2 | awk '
	BEGIN {FS=", | "}
	{for (i=1; i <= NF; i++) {printf("%d\n",$i)}}
	' | perl -pe '$_ = pack("l", $_)' > temp.bin

	sleep 1
	adb push temp.bin data/cspl_configs.bin
	rm temp.bin
}
#calibration

dir="am start -n com.android.music/com.android.music.MediaPlaybackActivity -d /sdcard/Music/"
#push_tuning
if [ $1 = "cal" ];then
   calibration
elif [ $1 = "lsmusic" ];then
	adb shell 'ls -l /sdcard/Music'
	adb shell 'ls -l /sdcard/Music/cirrus'
elif [ $1 = "push" ];then
	if [ $# = 3 ];then
		stop_music
		#push tuning
		echo | cat $2 - $3 | awk '
		BEGIN {FS=", | "}
		{for (i=1; i <= NF; i++) {printf("%d\n",$i)}}
		' | perl -pe '$_ = pack("l", $_)' > temp.bin

		sleep 1
		adb push temp.bin data/cspl_configs.bin
		rm temp.bin
		switch_config
	else
		echo "error: run like this: ./tune.sh mpush rx tx"
		exit 0
	fi
elif [ $1 = "mpush" ];then
	if [ $# = 4 ];then
		stop_music
		#push tuning
		echo | cat $2 - $3 | awk '
		BEGIN {FS=", | "}
		{for (i=1; i <= NF; i++) {printf("%d\n",$i)}}
		' | perl -pe '$_ = pack("l", $_)' > temp.bin

		sleep 1
		adb push temp.bin data/cspl_configs.bin
		rm temp.bin

		#play music
		switch_config
		playback
	else
		echo "error: run like this: ./tune.sh mpush rx.config tx.config .wav"
		exit 0
	fi
elif [ $1 = "vpush" ];then
	if [ $# = 3 ];then
		stop_music
		#push tuning
		echo | cat $2 - $3 | awk '
		BEGIN {FS=", | "}
		{for (i=1; i <= NF; i++) {printf("%d\n",$i)}}
		' | perl -pe '$_ = pack("l", $_)' > temp.bin

		sleep 1
		adb push temp.bin data/cspl_configs.bin
		rm temp.bin
		switch_config
	else
		echo "error: run like this: ./tune.sh mpush rx.config tx.config .wav"
		exit 0
	fi	
elif [ $1 = "stopmusic" ];then
	stop_music
elif [ $1 = "read" ];then
	cal_read
else
	exit 0
fi
