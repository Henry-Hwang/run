#!/bin/bash
ppattern="cirrus voice tuning"
prjdir=~/workspace/d/svn/x30-l2
ftinysys=${prjdir}/vendor/mediatek/proprietary/tinysys/freertos/source/drivers/common/audio/tasks/spkprotect/audio_task_speaker_protection.c
fdriver=${prjdir}/kernel-4.4/drivers/misc/cspl/cspl_ipi_driver.h

function voice-t-replace(){
	local include="#include $1_voice.h // $ppattern"
	local line=$(sed -n "/$ppattern/=" $fdriver)
	echo $include
	echo $line
	sed -i "${line}c ${include}" $fdriver
}
function playback-t-replace(){
	local bline=$(sed -n '/cirrus\ playback\ tuning/=' $fdriver)
	echo $pbline

}
# Replace the line of the given line number with the given replacement in the given file.
function replace-line-in-file() {
    local file="$1"
    local line_num="$2"
    local replacement="$3"
    
    # Escape backslash, forward slash and ampersand for use as a sed replacement.
    replacement_escaped=$( echo "$replacement" | sed -e 's/[\/&]/\\&/g' )
    
    sed -i "${line_num}s/.*/$replacement_escaped/" "$file"
}
voice-t-replace $1
playback-t-replace