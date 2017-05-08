#!/bin/bash
ppattern="cirrus playback tuning"
vpattern="cirrus voice tuning"
product=mz6799_6m_v2_n
prjdir=/opt/ubt-work/src/customer/meizu/x30-l2
dir_output=output
DIR_TINYSYS=${prjdir}/vendor/mediatek/proprietary/tinysys/freertos/source/middleware/smartpa/CSPL
DIR_DRIVER=${prjdir}/kernel-4.4/drivers/misc/cspl

#TEST
#DIR_TINYSYS=.
#DIR_DRIVER=.

dir_out=${prjdir}/out/target/product/$product
ftinysys=${DIR_TINYSYS}/cspl_task.h
fdriver=${DIR_DRIVER}/cspl_ipi_driver.h
voc_tuning=$2
play_tuning=$2
FILE_CONFIG=
#For make
DIR_MAKE=
VAR_LUNCH=
function show-dir(){
	echo $product
	echo $prjdir
	echo $DIR_TINYSYS
	echo $DIR_DRIVER
	echo $dir_out
	echo $ftinysys
	echo $fdriver
	echo $dir_output
}

function helper() {
	echo "===================================================================================="
	echo "Usage:
	 ./place.sh [options] [file]
	
	Options:
	 -h         help
	 -v <file>  voice tuning
	 -p <file>  playback tuning
	 -d <directory> source directory that contain the configuration, such as usb hard driver
	 -s <directory> copy the configuration from source directory to here

	Notice:
		No allow space in file name!!
	Example 1:
		We don't know which tuning for integrating, just want to select one
		./place.sh -v <null> -d <directory> -s <directory>

	Example 2:
		We know the exact configuration, default path is the current directory script will 
		search over all sub-directory
	   ./place.sh -v <file>
	   ./place.sh -p <file>
	   ./place.sh -v null -d /media/henry/20170317_22/playback/Logan/1792
	 "
	 echo "===================================================================================="
}

#Split the string with a seperator
#$1 : Seperator
#$2 : String
#Notice : no allow space in string and don't know if it work in android
#Example: str_split "," "$string"
SPLIT_ARRAY=
function str_split(){
	unset SPLIT_ARRAY
	#string="mark:x:0:0:this is a test string:/var/mark:nologin"
	#no allow space in the string
	local string=$(echo "$2" | sed s/[[:space:]]//g)
	local seperator=$1
	
	i=1
	while((1==1))  
	do  
	    local split=`echo $string|cut -d "$seperator" -f $i`  
	    if [ "$split" != "" ]; then        
	        echo $split
	        ((i++))
	        SPLIT_ARRAY[$i-1]=$split 
	    else  
	            break  
	    fi  
	done

#	for((i=0; i<${#SPLIT_ARRAY[@]}; i++)); do
#		echo "SPLIT_ARRAY[$i] : ${SPLIT_ARRAY[$i]}"
#	done	
}

function include_voice_tuning(){
	local include="#include \"$1\" // $vpattern"
	search-replace-line "$vpattern" "$include" "$ftinysys"
	include="#include \"$2\" // $vpattern"
	search-replace-line "$vpattern" "$include" "$fdriver"
}
function include_playback_tuning(){
	local include="#include \"$1\" // $ppattern"
	search-replace-line "$ppattern" "$include" "$fdriver"
}

#Search the line that include the "string" in the file then relace with the line
#$1 pattern in the line
#$2 The new line
#$3 Target file
#Notice: Be care of the space in the Line
#Example: search-replace-line "$str" "$line" $file
function search-replace-line(){
	local line=$(sed -n "/$1/=" $3)
	check_exit ${line:-null} "Error: No pattern in [$3]!!" "null" $LINENO
	sed -i "${line}c ${2}" $3
}

function copy-image(){
	cp -v $dir_out/boot.img $dir_output/
	cp -v $dir_out/tinysys-scp.bin $dir_output/
	mv -v $dir_output/boot.img $dir_output/${voc_tuning}-boot.img
	mv -v $dir_output/tinysys-scp.bin $dir_output/${voc_tuning}-tinysys-scp.bin	
}

function copy_voc_tuning_to_project(){
	cp -v $FILE_CONFIG $DIR_TINYSYS
	cp -v $1 $DIR_DRIVER
}
function copy-play-tuning(){
	cp -v $FILE_CONFIG $DIR_DRIVER	
}
function generate_second_voice_header(){
	cat $1 | sed -e 's/_RX/_RX_VOICE/g; s/_TX/_TX_VOICE/g' | grep "CSPL_CONFIG_" > "./$2"
}
function make-image(){
	str_split "," "$1"	
	local directory=${SPLIT_ARRAY[0]}
	local option=${SPLIT_ARRAY[1]}
	if [ ! -d $directory ]; then
		echo "Error: Android directory no exist!"
		exit
	fi
	
	cd $directory
	source build/envsetup.sh && lunch $option
	./vendor/mediatek/proprietary/tinysys/freertos/source/tools/build_tinysys.sh
	check_exit $? "cirrus make scp error" "" $LINENO

	make bootimage -j8
	check_exit $? "cirrus make kernel error" "" $LINENO

	cd -
}

#Check the return status of the function , exit if fault.
#For 0 exit, set the $3 to anything
#$1 : the status of functiom
#$2 : print error message
#$3 : invert, no-invert for return status, invert for check 0 exit (no use)
#$4 : Line Number
#Exampe: check_exit $? "my god" "" $LINENO
#        check_exit ${input:-null} "my god" "" $LINENO
function check_exit() {
	local status=0
	#echo "argn: $#, arg 1 = $1"
	if [ $1 = "null" ]; then
		status=1
	elif [ ! -n "$1" ]; then
		status=1
	fi

	if [ $status -eq 1 ]; then
		echo "Exit($4) --- $2"
		exit
	fi
}


#Store the output array in CMDOUT_ARRAY
#$1 is command
CMDOUT_ARRAY=
function cmd_2_array(){
	#clean array
	unset CMDOUT_ARRAY 
	local cmd=$1
	$cmd > ./__TEMP_STORE
	local count=$(sed -n '$=' ./__TEMP_STORE)
	#echo "count=$count"
	#count will be "null" if nothing in the file
	check_exit ${count:-null} "Error: Can not find $1!!" "null" $LINENO
	#sed count line in file from 1, not 0
	for((i=1; i<=$count; i++)); do
		CMDOUT_ARRAY[$i - 1]=$(sed -n "${i}p" __TEMP_STORE)
	done


	#for((i=0; i<$count; i++)); do
	#	echo "CMDOUT_ARRAY[$i] : ${CMDOUT_ARRAY[$i]}"
	#done
	rm ./__TEMP_STORE
}

function find-select-config(){
	cmd_2_array "find $DIR_SRC -name $1 -type f"
	#get the array lenght
	local lines=${#CMDOUT_ARRAY[@]}
	check_exit ${lines:-null} "Error: Can not find $1!!" "invert" $LINENO
	if [ $lines -gt 1 ]; then
		for((i=0; i<$lines; i++)); do
			echo "$i : ${CMDOUT_ARRAY[$i]}"
		done
		while true
		do
    		read -p "Which One ? :" select
    		if [ $select -lt $lines ]&&[ $select -ge 0 ]; then
				break
			fi
		done
		FILE_CONFIG=${CMDOUT_ARRAY[$select]}
	else
		FILE_CONFIG=${CMDOUT_ARRAY[0]}
	fi
}
#$1 : Directory
#return SELECTED
SELECTED=
function select_file_in_directory(){
	if [ -n "$1" ]; then
		#TODO Check space in the file name
		echo "Will not display the filename with [SPACE]"
		local ls_list=$(ls -t "$1" |grep -E "\.txt|\.h"  |grep -v " ")
		#ls_list=$(find "$DIR_SRC" -name "*.h" | xargs basename -a) 
		#return $SELECTED
		select_one_file_from_list 10 $ls_list
		echo $SELECTED
	else
		echo "Error: No directory specified"
		helper
		exit
	fi
}
#$1 : The Max number of the items for showing
#$2...$n : List of result of the files
#return SELECTED
function select_one_file_from_list(){
	#echo $#
	local line_array
	local args=
	let args=$#-2
	i=0
	shift
	for((i=0; i<=$args; i++)); do
		
		#if [ -d ${DIR_SRC}/"$1" ]; then
		#	echo "$1 is a directory"
		#	shift
		#	continue
		#fi
		
		line_array[$i]="$1"
		shift
	done
	local count=${#line_array[@]}

	for((i=0; i<$count; i++)); do
		echo "$i  : ${line_array[$i]}"
	done

	while true
	do
    	read -p "Which One ? :" select
    	#echo $select
    	if [ $select -lt $count ]&&[ $select -ge 0 ]; then
			break
		fi
	done
	SELECTED=${line_array[$select]}
	#echo ${line_array[$select]}
}
function voice_proc(){
	find-select-config $1
	check_exit ${FILE_CONFIG:-null} "Error: Configuration file not found!!" "null" $LINENO
	#~/docs/file.h --->file.h
    fname=$(basename $FILE_CONFIG)
    #get extend from base name, file.h --> h
    extended=${fname##*.}
    #create a new name for CONFIG
    #example: file.h --> file_voice.h
    local driver_header=$(basename $FILE_CONFIG .$extended)_voice.h

    #new file base on input file
	generate_second_voice_header $FILE_CONFIG $driver_header
	check_exit $? "cirrus script error"

	#copy new tuning file to the right directory
	copy_voc_tuning_to_project $driver_header 
	rm $driver_header

	#modify the header file to include new tuning
	include_voice_tuning $(basename $FILE_CONFIG) $driver_header
}

function playback_process(){
	find-select-config $1
	#echo "Config: $FILE_CONFIG"
	copy-play-tuning
	include_playback_tuning $(basename $FILE_CONFIG)
}

#str_split ":" "mark:x:0:0:this is a test user:/var/mark:nologin"
DIR_COPY_STORE=
DIR_SRC=
CFG_PLAYBACK=
CFG_VOICE=
#echo "OPTIND starts at $OPTIND"
while getopts ":p:v:hm:l:d:c:" optname
do
    case "$optname" in
    "p")
        #echo "Option $optname has value $OPTARG"
        #playback_process $OPTARG
        CFG_PLAYBACK=$OPTARG
        ;;
    "v")
        #echo "Option $optname has value $OPTARG"
        #voice_proc $OPTARG
        CFG_VOICE=$OPTARG
        ;;
    "m")
        #echo "Option $optname has value $OPTARG"
        #TODO make
        make-image "$OPTARG"
        exit
        ;;
    "d")
        #echo "Option $optname has value $OPTARG"
        #TODO set lunch option
        DIR_SRC=$OPTARG
        ;;
    "c")
        #echo "Option $optname has value $OPTARG"
        #TODO set lunch option
        DIR_COPY_STORE=$OPTARG
        ;;                  
    "l")
        #echo "Option $optname has value $OPTARG"
        #TODO set lunch option
        VAR_LUNCH=$OPTARG
        ;;  
    "h")
        helper
        ;;        
    "?")
        echo "Unknown option $OPTARG"
        exit
        ;;
    ":")
        echo "No argument value for option $OPTARG"
        exit
        ;;
    *)
        # Should not occur
        echo "Unknown error while processing options"
        ;;
    esac
		echo "OPTIND is now $OPTIND"
done

select_file_in_directory "$DIR_SRC"

if [ -n "$CFG_PLAYBACK" ]; then
	echo "Replace playback tuning: "
	if [ $CFG_PLAYBACK = "null" ]; then
		playback_process $SELECTED
	else
		playback_process $CFG_PLAYBACK
	fi

elif [ -n "$CFG_VOICE" ]; then
	echo "Replace voice tuning: "
	if [ $CFG_VOICE = "null" ]; then
		voice_proc $SELECTED
	else
		voice_proc $CFG_VOICE
	fi
fi