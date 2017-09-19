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
##Calibration test
- Put speaker_cal.wav into /data/data/
- Put factorytest into /system/bin
- Run factorytest
~~~script
   #factorytest pa_calibrate
~~~
##scp compile
~~~script
./vendor/mediatek/proprietary/tinysys/freertos/source/tools/build_tinysys.sh
~~~
##scp mips

scp mips votage level, level 1 will cosumer most power

|  level    |  rang      |   |
| ----------|---------------|----------------| 
|  1         |  286~416   |     |
|  2         | 165~286    |      |
|  3         | 82~165        |      |
|  4         | 0~82        |      |

~~~patch
diff --git a/drivers/misc/mediatek/scp/mt6799/scp_feature_table.c b/drivers/misc/mediatek/scp/mt6799/scp_feature_table.c
index b0bb785..7b6f255 100644
--- a/drivers/misc/mediatek/scp/mt6799/scp_feature_table.c
+++ b/drivers/misc/mediatek/scp/mt6799/scp_feature_table.c
@@ -55,7 +55,7 @@ scp_feature_tb_t feature_table[NUM_FEATURE_ID] = {
        },
        {
                .feature    = SPEAKER_PROTECT_FEATURE_ID,
-               .freq       = 416,
+               .freq       = 300,
                .core       = SCP_B_ID,
                .enable     = 0,
        },
~~~
##scp log
- enable scp log
~~~patch
diff --git a/project/CM4_B/mt6799/mz6799_6m_v2_n/ProjectConfig.mk b/project/CM4_B/mt6799/mz6799_6m_v2_n/ProjectConfig.mk
index 8106aec..51ac7ca 100644
--- a/project/CM4_B/mt6799/mz6799_6m_v2_n/ProjectConfig.mk
+++ b/project/CM4_B/mt6799/mz6799_6m_v2_n/ProjectConfig.mk
@@ -15,4 +15,4 @@ CFG_SLEEP_SUPPORT = yes
 CFG_UART_SUPPORT = no
 CFG_SCP_UART1_SUPPORT = no
 CFG_MTK_SPEAKER_PROTECTION_SUPPORT = yes
-CFG_LOGGER_SUPPORT = no
+CFG_LOGGER_SUPPORT = yes

~~~
- scp log file
~~~script
/sys/class/misc/scp_B/
scp_B-get_last_log
~~~
##Audio Dump
- config
Phone APP --> *#*#3646633#*#* -->Hardware Test -->Audio-->Speech logger
enable vm log ( v )
- audio dump
/sdcard/mtklog/audio_dump
##Extend feedback buffer
- extended to 24k
~~~patch
diff --git a/sound/soc/mediatek/common_int/mtk-soc-pcm-dl1-scpspk.c b/sound/soc/mediatek/common_int/mtk-soc-pcm-dl1-scpspk.c
index 6c26d25..d75bc8f 100644
--- a/sound/soc/mediatek/common_int/mtk-soc-pcm-dl1-scpspk.c
+++ b/sound/soc/mediatek/common_int/mtk-soc-pcm-dl1-scpspk.c
@@ -412,7 +412,7 @@ static int dl1spk_allocate_feedback_buffer(struct snd_pcm_substream *substream,
        int ret = 0;
        unsigned int buffer_size = 0;
 
-       buffer_size = params_buffer_bytes(hw_params);
+       buffer_size = 1024*24;
        Dl1Spk_feedback_buf.bytes = buffer_size;
        if (AllocateAudioSram(&Dl1Spk_feedback_buf.addr,
                        &Dl1Spk_feedback_buf.area,

~~~
##Extend playback buffer
- extended to 32k
~~~patch
diff --git a/common/V3/aud_drv/AudioALSAPlaybackHandlerSpeakerProtectionDsp.cpp b/common/V3/aud_drv/AudioALSAPlaybackHandlerSpeakerProtectionDsp.cpp
index ba939a6..59b3f51 100644
--- a/common/V3/aud_drv/AudioALSAPlaybackHandlerSpeakerProtectionDsp.cpp
+++ b/common/V3/aud_drv/AudioALSAPlaybackHandlerSpeakerProtectionDsp.cpp
@@ -131,7 +131,7 @@ status_t AudioALSAPlaybackHandlerSpeakerProtectionDsp::open()
     ALOGD("%s(): pcmindex = %d", __FUNCTION__, pcmindex);
     ListPcmDriver(cardindex, pcmindex);
 
-    mStreamAttributeTarget.buffer_size =  AudioALSADeviceParser::getInstance()->GetPcmBufferSize(pcmindex, PCM_OUT);
+    mStreamAttributeTarget.buffer_size =  32*1024;
 
 #ifdef PLAYBACK_USE_24BITS_ONLY
     mStreamAttributeTarget.audio_format = AUDIO_FORMAT_PCM_8_24_BIT;
@@ -153,7 +153,7 @@ status_t AudioALSAPlaybackHandlerSpeakerProtectionDsp::open()
     if(mStreamAttributeTarget.sample_rate > 16000)
     {
 
-        mConfig.period_count = 5;
+        mConfig.period_count = 4;
         mConfig.period_size = (mStreamAttributeTarget.buffer_size / (mConfig.channels * mConfig.period_count)) / ((mStreamAttributeTarget.audio_format == AUDIO_FORMAT_PCM_16_BIT) ? 2 : 4);
 
         mConfig.format = transferAudioFormatToPcmFormat(mStreamAttributeTarget.audio_format);

~~~
##Force use SRAM (Disable DRAM)
- SRAM is has a limit size,

~~~patch
diff --git a/sound/soc/mediatek/common_int/mtk-soc-pcm-dl1-scpspk.c b/sound/soc/mediatek/common_int/mtk-soc-pcm-dl1-scpspk.c
index 6c26d25..cd155c5 100644
--- a/sound/soc/mediatek/common_int/mtk-soc-pcm-dl1-scpspk.c
+++ b/sound/soc/mediatek/common_int/mtk-soc-pcm-dl1-scpspk.c
@@ -594,7 +594,7 @@ static int mtk_pcm_dl1spk_open(struct snd_pcm_substream *substream)
        runtime->hw = mtk_dl1spk_hardware;
 
        AudDrv_Clk_On();
-       AudDrv_Emi_Clk_On();
+       //AudDrv_Emi_Clk_On();
        memcpy((void *)(&(runtime->hw)), (void *)&mtk_dl1spk_hardware,
               sizeof(struct snd_pcm_hardware));
        pdl1spkMemControl = Get_Mem_ControlT(Soc_Aud_Digital_Block_MEM_DL1);
@@ -676,7 +676,7 @@ static int mtk_pcm_dl1spk_close(struct snd_pcm_substream *substream)
 
        spk_irq_cnt = 0;    /* reset spk_irq_cnt */
        AudDrv_Clk_Off();
-       AudDrv_Emi_Clk_Off();
+       //AudDrv_Emi_Clk_Off();
        vcore_dvfs(&vcore_dvfs_enable, true);
        return 0;
 }

~~~
##reduce CM4-A SRAM to 256K，increace CM4-B SRAM to 512K
~~~patch

diff --git a/project/CM4_A/mt6799/mz6799_6m_v2_n/project.ld b/project/CM4_A/mt6799/mz6799_6m_v2_n/project.ld
index 2ac6b8b..852d942 100644
--- a/project/CM4_A/mt6799/mz6799_6m_v2_n/project.ld
+++ b/project/CM4_A/mt6799/mz6799_6m_v2_n/project.ld
@@ -1,5 +1,5 @@
 /*SCP sram size*/
-_SCP_SRAM_SIZE = 0x80000;
+_SCP_SRAM_SIZE = 0x40000;
 
 /* reserved memory areas*/
 _SCP_IPC_SHARE_BUFFER_ADDR = _SCP_SRAM_SIZE - 0x240;
@@ -10,5 +10,5 @@ _SCP_TO_CNN_SHARE_BUFFER_ADDR = _CNN_TO_SCP_SHARE_BUFFER_ADDR - 0x40;
 MEMORY
 {
   LOADER (rwx)        : ORIGIN = 0x00000000, LENGTH =   2K /*loader for recovery use*/
-  RTOS   (rwx)        : ORIGIN = 0x00000800, LENGTH = 510K
+  RTOS   (rwx)        : ORIGIN = 0x00000800, LENGTH = 254K
 }

diff --git a/project/CM4_B/mt6799/mz6799_6m_v2_n/project.ld b/project/CM4_B/mt6799/mz6799_6m_v2_n/project.ld
index 6713443..0fb46aa 100644
--- a/project/CM4_B/mt6799/mz6799_6m_v2_n/project.ld
+++ b/project/CM4_B/mt6799/mz6799_6m_v2_n/project.ld
@@ -1,5 +1,5 @@
 /*SCP sram size*/
-_SCP_SRAM_SIZE = 0x40000;
+_SCP_SRAM_SIZE = 0x80000;
 
 /* reserved memory areas*/
 _SCP_IPC_SHARE_BUFFER_ADDR = _SCP_SRAM_SIZE - 0x240;
@@ -8,5 +8,5 @@ _SCP_IPC_SHARE_BUFFER_ADDR = _SCP_SRAM_SIZE - 0x240;
 MEMORY
 {
   LOADER (rwx)        : ORIGIN = 0x00000000, LENGTH =   2K /*loader for recovery use*/
-  RTOS   (rwx)        : ORIGIN = 0x00000800, LENGTH = 254K
+  RTOS   (rwx)        : ORIGIN = 0x00000800, LENGTH = 510K
 }
diff --git a/project/CM4_B/mt6799/platform/platform.mk b/project/CM4_B/mt6799/platform/platform.mk
index 3a49e8a..4cc26dc 100755
--- a/project/CM4_B/mt6799/platform/platform.mk
+++ b/project/CM4_B/mt6799/platform/platform.mk
@@ -95,7 +95,7 @@ CFLAGS += -DconfigTOTAL_HEAP_SIZE='( ( size_t ) ( 165 * 1024 ) )'
 else ifeq ($(CFG_MTK_SPEAKER_PROTECTION_SUPPORT),yes)
 # MEIZU comment: use cirrus debug value
 #CFLAGS += -DconfigTOTAL_HEAP_SIZE='( ( size_t ) ( 70 * 1024 ) )'
-CFLAGS += -DconfigTOTAL_HEAP_SIZE='( ( size_t ) ( 50 * 1024 ) )'
+CFLAGS += -DconfigTOTAL_HEAP_SIZE='( ( size_t ) ( 280 * 1024 ) )'
 else
 # default heap size
 CFLAGS += -DconfigTOTAL_HEAP_SIZE='( ( size_t ) ( 60 * 1024 ) )'
~~~
##tuning script
~~~script
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

~~~
##mtk gpio set
~~~script
cd /sys/devices/virtual/misc/mtgpio/
echo  -w=179:x x x x x x x x x x > pin
~~~
~~~script
echo -wdout 179 0 > pin
echo -wdout 179 1 > pin
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




