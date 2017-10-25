#M1781 note
##Audio Resource
| Module | max |  min     |  ||
| ----------|------	|---------|---------|-------| 
|  MI2S 	|  960     |    960	|
|  MI2S  		| 4080    |  3064   	|
|  AIF1	| 16444  | 14180      |
|  AIF1       	| 59        |    59  	|
|  Total        			| 21543  |    18263  	|

    M1781 Audio Block Diagram:
    +-----------------------+          +-------------------+
    |                       |          |                   |
    |    SDM660             |          |  External Codec   |
    |                       |          |  (CS47L35)        +-->Headphone
    |                       |          |                   |
    |                       |          |   +-------------+ +-->Main_MIC
    |       +-----------+   |          |   |Sound Trigger| |
    |       |           | MI2S3      AIF1  +-------------+ +-->Sub_MIC
    |       |           |   <---------->                   |
    |       |           |   |          |   +-------------+AIF2 +--------+
    |       |           |   |          |   |Press & Motor| +--->Motor PA+-->Motor
    |       |           |   |          |   +-------------+ |   +--------+
    |       |           |   |          |                   |
    |       |           |   |          +-------------------+
    |       |  Hexagon  |   |
    |       |  aDSP     |   |          +-------------------+
    |       |           |  PDM         |                   |
    |       |           |   <---------->  Internal Cocec   +-->Earphone
    |       |           |   |          |  (PM660A Codec)   |
    |       |           |   |          +-------------------+
    |       |           |   |
    |       |           |   |          +-------------------+
    |       |           | MI2S2        |                   |
    |       |           |   <---------->    Speaker PA     +-->Speaker
    |       +-----------+   |          |    (CS35L35)      |
    +-----------------------+          +-------------------+


##Tinyplay Test
~~~script
Speaker:
         tinymix "SEC_MI2S_RX Audio Mixer MultiMedia1" 1 \
         && tinyplay /sdcard/Music/cirrus/music/ChuanGe48K.wav &
 
Headphone:
         tinymix "TERT_MI2S_RX Audio Mixer MultiMedia1" 1 \
         && tinymix "HPOUT1L Input 1" "AIF1RX1" \
         && tinymix "HPOUT1R Input 1" "AIF1RX2" \
         && tinymix "HPOUT1 Digital Switch" 1 \
         && tinymix "HP Switch" 1 \
         && tinyplay /sdcard/Music/cirrus/music/ChuanGe48K.wav &
~~~

##Tinycap Test
~~~script
HeadsetMIC Record:
        tinymix "MultiMedia1 Mixer TERT_MI2S_TX" 1 \
        && tinymix "IN1R Mux" "B" \
        && tinymix "AIF1TX1 Input 1" "IN1R" \
        && tinymix "AIF1TX2 Input 1" "IN1R" \
        && tinymix "Headset Mic Switch" "1"  \
        && tinycap /data/data/cirrus-rec-test.wav &
        
        
 Speaker Playback:
        tinymix "SEC_MI2S_RX Audio Mixer MultiMedia1" 1 \
        && tinycap /data/data/cirrus-rec-test.wav
        
 Headphone Playback:
        tinymix "TERT_MI2S_RX Audio Mixer MultiMedia1" 1
        tinymix "HPOUT1L Input 1" "AIF1RX1"
        tinymix "HPOUT1R Input 1" "AIF1RX2"
        tinymix "HPOUT1 Digital Switch" 1
        tinymix "HP Switch" 1   
~~~
##Smart PA Test
```script
		tinymix "CIRRUS GB ENABLE" "Config GB Disable" \
		&& tinymix "FBProtect Port" "SEC_MI2S_RX" \
		&& sleep 1 \
		&& tinymix "SEC_MI2S_RX Audio Mixer MultiMedia1" 1 \
		&& sleep 2 \
		&& tinymix "CIRRUS GB ENABLE" "Config GB Enable" \
		&& tinyplay /sdcard/Music/cirrus/music/ChuanGe48K.wav &
```
```script
		tinymix "CIRRUS GB ENABLE" "Config GB Disable" \
		&& tinymix "FBProtect Port" "SEC_MI2S_RX" \
		&& sleep 1 \
		&& tinymix "SEC_MI2S_RX Audio Mixer MultiMedia1" 1 \
		&& sleep 2 \
		&& tinymix "CIRRUS GB ENABLE" "Config GB Enable" \
		&& tinymix "CIRRUS GB EXT CONFIG" "Config RX New" \
		&& tinymix "CIRRUS GB EXT CONFIG" "Config TX New" \
		&& tinymix "CIRRUS GB CONFIG" "Path_for_Music" \		
		&& tinyplay /sdcard/Music/cirrus/music/ChuanGe48K.wav &
```
```script
		tinymix 'CIRRUS GB CONFIG' 'Run Diag'
		tinymix 'CIRRUS GB CONFIG' 'Set Temp Cal' 
		tinymix 'CIRRUS GB CONFIG' 'Get Current Temp' 
		tinymix 'CIRRUS GB CONFIG' 'Set Fo Cal'
		tinymix 'CIRRUS GB CONFIG' 'Path_for_Music'
		tinymix 'CIRRUS GB CONFIG' 'Path_for_Voice'
		tinymix 'CIRRUS GB CONFIG' 'Path_for_Dolby'
```

##Tone To Headphone

~~~script
		tinymix "HPOUT1L Input 1" "Tone Generator 1"
		tinymix "HPOUT1 Digital Switch" 1
		tinymix "HP Switch" 1 
~~~
##Record Force Sensor data
~~~script
		tinymix "MultiMedia1 Mixer TERT_MI2S_TX" 1
		tinymix "IN1L Mux" "A"
		tinymix "AIF1TX1 Input 1 Volume" "47"
		tinymix "AIF1TX1 Input 1" "IN1L"
		tinymix "AIF1TX2 Input 1" "IN1L"
		tinymix "Haptic Mic Switch" "1"
		tinymix "IN1L Volume" "30"
		tinymix "IN1L Digital Volume" "190"
		tinycap /data/cirrus/cirrus-rec-test.wav &
~~~
##Enable machine QDSP kernel log
```script
#!/bin/bash
#adb shell
#mount -t debugfs debugfs /sys/kernel/debug
adb wait-for-device
adb root
adb remount
adb shell "echo file q6afe.c +p > /sys/kernel/debug/dynamic_debug/control"
adb shell "echo file q6adm.c +p > /sys/kernel/debug/dynamic_debug/control"
adb shell "echo file q6asm.c +p > /sys/kernel/debug/dynamic_debug/control"
adb shell "echo file audio_acdb.c +p > /sys/kernel/debug/dynamic_debug/control"
adb shell "echo file msm-pcm-q6-v2.c +p > /sys/kernel/debug/dynamic_debug/control"
adb shell "echo file msm-pcm-routing-v2.c +p > /sys/kernel/debug/dynamic_debug/control"
adb shell "echo file msm-cirrus-playback.c +p > /sys/kernel/debug/dynamic_debug/control"
```
##Enable QDSP log on QXDM
View------>Common---->massage View
Right click on Massage View window, config---->Massage Packet, On right window ticket QDSP6,  there is a list under QDSP6, tick 
##Enable PCM loging
View------>Common---->massage View
Right click on Massage View window, config---->Log Packet---->Common----->ADSP----->QTI---->1586
##QACT ISF to WAV

View------>Vocoder Playback---->Process
##ADCB
- path in linux file system
~~~script
/etc/acdbdata/MTP
~~~
- path in android project
~~~script
vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/sdm660/MTP/
~~~
##Code Size
zhongqinglong@zhongqinglong:~/workspace/d/x30-l2/out/target/product/mz6799_6m_v2_n/obj/TINYSYS_OBJ/tinysys-scp_intermediates/freertos/source/CM4_B/drivers/common/audio/tasks/spkprotect$ arm-linux-androideabi-objdump -S audio_task_speaker_protection.o

~~~script
							InterleaveData(2, processingframebytes, -8, ppLRBuffers, (int32_t *)audioLinearBuf + (2*i*Processingframecount));
 d24:	00000000 	.word	0x00000000
 d28:	0000029e 	.word	0x0000029e
 d2c:	000002d3 	.word	0x000002d3
 d30:	00000000 	.word	0x00000000
 d34:	00000308 	.word	0x00000308
	...
						processingframebytes = frame_to_bytes(Processingframecount, uSpeaker_Protection_Info.mdlchannel,
																uSpeaker_Protection_Info.mdlformat);
						processingIVframebytes = frame_to_bytes(Processingframecount, uSpeaker_Protection_Info.mdlchannel,
																Soc_Aud_I2S_WLEN_WLEN_32BITS);
						int i;
						for (i = 0; i < 21; i++) {
 d58:	00000325 	.word	0x00000325
 d5c:	00000000 	.word	0x00000000

~~~
##make adsp
~/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc
~~~script
python build/build.py -c sdm660 -o all
~~~
##push ADSP firmware
```script
adb wait-for-device
adb root
adb remount
adb shell "umount /firmware/"
adb shell "mount -o rw /dev/block/bootdevice/by-name/modem_a /firmware"
adb shell "rm /firmware/image/adsp.*"
adb push /home/sep/workspace/M1781/amss/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed/LA/system/etc/firmware/  /firmware/image
adb shell "ls -l /firmware/image | grep adsp"
adb reboot
```
##Install adsp
Installed "/home/sep/workspace/M1781/ADSP.VT.4.0/adsp_proc/build/bsp/multi_pd_img/build/660.adsp.prod/sign_and_encrypt/default/adsp/dsp2.mbn" to "/home/sep/workspace/M1781/ADSP.VT.4.0/adsp_proc/obj/qdsp6v5_ReleaseG/660.adsp.prod/signed_encrypted/adsp.mbn"
##Start QXDM
```script
sudo /usr/QXDM/QXDM
sudo /Applications/QCAT/QCAT/bin/QCAT
```
##Adb Disable Verity
```script
adb disable-verity 
```
##Adb Volume
~~~script
input keyevent VOLUME_UP
input keyevent VOLUME_DOWN
~~~

##git revert
must revert from top to bottun , one by one

##Tommy power issue

measure point TP2102 TP2103
I=V/R


![Alt text](/home/zhongqinglong/workspace/cirrus/docs/tommy-power-measure-point.jpg)


Current measure result:

|  driver    |  playback  |  standby |
| ------------- |------------------|----------------| 
|  latest     |      65 am    |    10 am   |
|  old          | 65 am         |   10 am     |
|  null         | 20 am          |   10 am     |




