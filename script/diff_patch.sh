#author :jscese
# $1 - source code
# $2 - modify code
# $1 and $2 Have the same target directory  -example: ./diff_patch.sh  xxx/xxx/kodi_***/addons  xxx/kodi_***/addons
# the script create patch_directory<$patch_name> in current derectory
#!/bin/bash
basedir="./"
patch_name="kodi_modif_patch"
dir1=$1
dir2=$2
dir3="$(echo $dir1 | sed "s/^[^\/]*/${patch_name}/")"
diff_out="diff_between_patch.log"
echo "$dir1  $patch_name  $dir3"
tempf="$(mktemp -p $basedir)"
find $PWD/$dir1 -type f >$tempf
if [ -f "${diff_out}" ];then
        mv "${diff_out}" "${diff_out}-$(date +%H%M%S)"
fi
if [ -d "${patch_name}" ];then
        echo "already exit patch"
        rm -rf ${patch_name}

fi

if [ -z "$tempf" ];then
        exit 1
fi
echo "begain check"
for myfile in $(cat $tempf)
do
        myfile2="$(echo $myfile | sed "s:$dir1:$dir2:")"
        if [ -f "$myfile2" ];then
             cmp -s $myfile $myfile2
             return_value=$?
             if [ "$return_value" == 1 ];then
              #diff -u $myfile $myfile2 | tee -a "$diff_out"
              myfile3="$(echo $myfile | sed "s:$dir1:$dir3:")"
              targdir=$(dirname $myfile3)
              mkdir -p $targdir
              cp -fp $myfile2 $myfile3
             fi
        else
                echo "$myfile2 not exist!"
        fi
done    
rm -f $tempf
