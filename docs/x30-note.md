#x30 note
##Nodeps make bootimage
This section shows how make  bootimage faster

- show commands
~~~script
#make bootimage -j24 showcommands
~~~
it show:
~~~script
[ 25% 1/4] /bin/bash -c "(mkdir -p /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ ) && (make -j12 -C kernel-4.4 O=/opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ ARCH=arm64 CROSS_COMPILE=/opt/ubt-work/src/customer/meizu/x30-l2/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- ROOTDIR=/opt/ubt-work/src/customer/meizu/x30-l2 GOODIX_FP_BIO_SUPPORT= ) && (if [ -e /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/compressed/.piggy.xzkern.cmd ]; then cp /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/compressed/.piggy.xzkern.cmd /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/compressed/.piggy.xzkern.cmd.bak; sed -e 's/\\\\\\\\\\\\\\\\/\\\\\\\\/g' < /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/compressed/.piggy.xzkern.cmd.bak > /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/compressed/.piggy.xzkern.cmd; rm -f /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/compressed/.piggy.xzkern.cmd.bak; fi )"
make: Entering directory `/opt/ubt-work/src/customer/meizu/x30-l2/kernel-4.4'
make[1]: Entering directory `/opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ'
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  GEN     ./Makefile
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  OBJCOPY arch/arm64/boot/Image
  GZIP    arch/arm64/boot/Image.gz
  CAT     arch/arm64/boot/Image.gz-dtb
make[1]: Leaving directory `/opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ'
make: Leaving directory `/opt/ubt-work/src/customer/meizu/x30-l2/kernel-4.4'
[ 50% 2/4] /bin/bash -c "out/host/linux-x86/bin/acp -fp /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb.bin"
[ 75% 3/4] /bin/bash -c "out/host/linux-x86/bin/acp -fp /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb.bin out/target/product/mz6799_6m_v2_n/kernel"
[100% 4/4] /bin/bash -c "out/host/linux-x86/bin/mkbootimg  --kernel out/target/product/mz6799_6m_v2_n/kernel --ramdisk out/target/product/mz6799_6m_v2_n/ramdisk.img --cmdline \"bootopt=64S3,32N2,64N2\" --base 0x40000000 --ramdisk_offset 0x05000000 --kernel_offset 0x00080000 --tags_offset 0x4000000 --board 1494464891 --os_version 7.0 --os_patch_level 2017-04-05 --kernel_offset 0x00080000 --ramdisk_offset 0x05000000 --tags_offset 0x4000000 --output out/target/product/mz6799_6m_v2_n/boot.img"

#### make completed successfully (03:29 (mm:ss)) ####
~~~
- sort out commands above
~~~script
mkdir -p /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ
~~~
~~~script
make -j12 -C kernel-4.4 O=/opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ ARCH=arm64 CROSS_COMPILE=/opt/ubt-work/src/customer/meizu/x30-l2/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- ROOTDIR=/opt/ubt-work/src/customer/meizu/x30-l2 GOODIX_FP_BIO_SUPPORT=
~~~
~~~script
out/host/linux-x86/bin/acp -fp /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb.bin
~~~
~~~script
out/host/linux-x86/bin/acp -fp /opt/ubt-work/src/customer/meizu/x30-l2/out/target/product/mz6799_6m_v2_n/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb.bin out/target/product/mz6799_6m_v2_n/kernel
~~~
~~~script
out/host/linux-x86/bin/mkbootimg  --kernel out/target/product/mz6799_6m_v2_n/kernel --ramdisk out/target/product/mz6799_6m_v2_n/ramdisk.img --cmdline \"bootopt=64S3,32N2,64N2\" --base 0x40000000 --ramdisk_offset 0x05000000 --kernel_offset 0x00080000 --tags_offset 0x4000000 --board 1494464891 --os_version 7.0 --os_patch_level 2017-04-05 --kernel_offset 0x00080000 --ramdisk_offset 0x05000000 --tags_offset 0x4000000 --output out/target/product/mz6799_6m_v2_n/boot.img
~~~
- final script
~~~script
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
~~~
##cspl heap size
| handle | max |  min     |  ||
| ----------|------	|---------|---------|-------| 
|  this->msg_array 	|  960     |    960	|
|  configArrays  		| 4080    |  3064   	|
|  csplRx(Tx)Context 	| 16444  | 14180      |
|  AudioTask *task        	| 59        |    59  	|
|  Total        			| 21543  |    18263  	|

~~~script
unlock_scp
[19]Heap: max/free/total:240720 250888 286720
Task Status:
TMon 	R	0	253	1
IDLE 	R	0	79	4
Tmr S	B	2	227	5
speak	B	2	1835	3
vow  	B	3	811	2
max duration: 0, limit: 0
[20]Heap: max/free/total:240720 250888 286720
Task Status:
TMon 	R	0	253	1
IDLE 	R	0	79	4
Tmr S	B	2	227	5
vow  	B	3	811	2
speak	B	2	1835	3

|240720 250888 286720|35832
~~~
##Code Size
zhongqinglong@zhongqinglong:~/workspace/d/x30-l2/out/target/product/mz6799_6m_v2_n/obj/TINYSYS_OBJ/tinysys-scp_intermediates/freertos/source/CM4_B/drivers/common/audio/tasks/spkprotect$ arm-linux-androideabi-objdump -S audio_task_speaker_protection.o

~~~script
henry@Dell5510:~/workspace/docs/cirrus/patch$ size audio_task_speaker_protection.o
   text	   data	    bss	    dec	    hex	filename
   9248	      4	  16974	  26226	   6672	audio_task_speaker_protection.o

henry@Dell5510:~/workspace/docs/cirrus/patch$ size ../libcspl/libcspl.a
   text	   data	    bss	    dec	    hex	filename
  12768	    300	      4	  13072	   3310	block_table.o (ex ../libcspl/libcspl.a)
~~~
##Remove VOW from SCP B
/device/mediatek$ git diff
~~~patch

diff --git a/mz6799_6m_v2_n/ProjectConfig.mk b/mz6799_6m_v2_n/ProjectConfig.mk
index 21e3b49..3d2f393 100755
--- a/mz6799_6m_v2_n/ProjectConfig.mk
+++ b/mz6799_6m_v2_n/ProjectConfig.mk
@@ -669,7 +669,7 @@ MTK_VOIP_ENHANCEMENT_SUPPORT = yes
 MTK_VOIP_HANDSFREE_DMNR = yes
 MTK_VOIP_NORMAL_DMNR = yes
 MTK_VOLTE_SUPPORT = yes
-MTK_VOW_SUPPORT = yes
+MTK_VOW_SUPPORT = no
 MTK_VPU_SUPPORT = yes
 MTK_VR_HIGH_PERFORMANCE_SUPPORT = no
 MTK_VSS_SUPPORT = no


~~~
kernel-4.4$ git diff
~~~patch

diff --git a/arch/arm64/configs/mz6799_6m_v2_n_debug_defconfig b/arch/arm64/configs/mz6799_6m_v2_n_debug_defconfig
index fffe943..ae23bfe 100644
--- a/arch/arm64/configs/mz6799_6m_v2_n_debug_defconfig
+++ b/arch/arm64/configs/mz6799_6m_v2_n_debug_defconfig
@@ -365,7 +365,7 @@ CONFIG_HMP_TRACER=y
 CONFIG_SCHED_HMP_PLUS=y
 CONFIG_MTK_SYSENV=y
 CONFIG_MICROTRUST_TEE_SUPPORT=y
-CONFIG_MTK_VOW_SUPPORT=y
+#CONFIG_MTK_VOW_SUPPORT=y
 CONFIG_MTK_FIQ_CACHE=y
 CONFIG_MOTOR_DRV260X=y
 CONFIG_MEIZU_RPMB_CTL_DRV=y

~~~
/vendor/mediatek/proprietary/tinysys/freertos/source$ git diff
~~~patch
diff --git a/project/CM4_B/mt6799/mz6799_6m_v2_n/ProjectConfig.mk b/project/CM4_B/mt6799/mz6799_6m_v2_n/ProjectConfig.mk
index 51ac7ca..3e23259 100644
--- a/project/CM4_B/mt6799/mz6799_6m_v2_n/ProjectConfig.mk
+++ b/project/CM4_B/mt6799/mz6799_6m_v2_n/ProjectConfig.mk
@@ -10,7 +10,7 @@
 # **** DO NOT **** define anything other than configuration options here.
 # If you need to customize project-specific source files, compiler flags
 # or required libraries, add them to CompilerOption.mk.
-CFG_MTK_VOW_SUPPORT = yes
+CFG_MTK_VOW_SUPPORT = no
 CFG_SLEEP_SUPPORT = yes
 CFG_UART_SUPPORT = no
 CFG_SCP_UART1_SUPPORT = no

~~~

##Adb Volume (simulate KEY)
~~~script
input keyevent VOLUME_UP
input keyevent VOLUME_DOWN
~~~
##Bypass SCP
~~~patch
diff --git a/common/V3/aud_drv/AudioALSALoopbackController.cpp b/common/V3/aud_drv/AudioALSALoopbackController.cpp
index 5e3cd1b..86956bd 100644
--- a/common/V3/aud_drv/AudioALSALoopbackController.cpp
+++ b/common/V3/aud_drv/AudioALSALoopbackController.cpp
@@ -14,10 +14,11 @@
 #ifdef MTK_CIRRUS_SPEAKER_SUPPORT
 #include "cspl_control.h"
 #include "MtkAudioComponent.h"
-#include <audio_memory_control.h>
+
 #include <cutils/properties.h>
 #include "AudioMessengerIPI.h"
 #endif
+#include <audio_memory_control.h>
 
 #define ALIGN(x, a) ((x) + (a) - 1) & ~((a)-1)
 
@@ -794,10 +795,11 @@ status_t AudioALSALoopbackController::openPlaybackPcm(const audio_devices_t outp
     {
         pcmindex = AudioALSADeviceParser::getInstance()->GetPcmIndexByString(keypcmDl1SpkPlayback);
         cardindex = AudioALSADeviceParser::getInstance()->GetCardIndexByString(keypcmDl1SpkPlayback);
-
-       pSpkIPI = AudioMessengerIPI::getInstance();
-       pSpkIPI->CSPLPlaybackConfig();
-       pSpkIPI->CSPLConfigSetup();
+#if defined (MTK_CIRRUS_SPEAKER_SUPPORT)
+          pSpkIPI = AudioMessengerIPI::getInstance();
+          pSpkIPI->CSPLPlaybackConfig();
+          pSpkIPI->CSPLConfigSetup();
+#endif    
     }
     else
     {
diff --git a/mt6799/Android.mk b/mt6799/Android.mk
index 93e19f1..0595dac 100755
--- a/mt6799/Android.mk
+++ b/mt6799/Android.mk
@@ -256,7 +256,7 @@ else
     ifeq ($(findstring cirrus, $(MTK_AUDIO_SPEAKER_PATH)), cirrus)
       LOCAL_C_INCLUDES += $(MTK_PATH_SOURCE)/hardware/audio/vendor_cirrus
       LOCAL_SHARED_LIBRARIES += libcspl_control
-      LOCAL_CFLAGS += -DMTK_CIRRUS_SPEAKER_SUPPORT
+      #LOCAL_CFLAGS += -DMTK_CIRRUS_SPEAKER_SUPPORT
       LOCAL_CFLAGS += -DEXTCODEC_ECHO_REFERENCE_SUPPORT
     endif

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




