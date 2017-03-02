#!/bin/bash
now=`date +"%Y-%m-%d-%H:%M:%S"`
path=$1
dir=$2
system=$3
filename="$system-backup-$now"
latest=`find $path | xargs ls -tr | tail -1`
oldFile="$(/usr/bin/find "$dir" -name ''"$system"'-backup-*')"
getFiles=(`ls $dir`)
a=0

echo "0 now $now"
echo "1 path $path"
echo "2 dir $dir"
echo "3 system $system"
echo "4 filename $filename"
echo "5 latest $latest"
echo "6 oldFile $oldFile"
echo "7 getFiles $getFiles"

if [ -d "$dir" ]; then
    for i in "${getFiles[@]}"
    do
        symLink
        ((a++))
        echo $a
    done
fi

function symLink(){

echo "hi"

echo "0 now $now"
echo "1 path $path"
echo "2 dir $dir"
echo "3 system $system"
echo "4 filename $filename"
echo "5 latest $latest"
echo "6 oldFile $oldFile"
echo "7 getFiles $getFiles"

#if [ "$filename" != "$oldFile" ] && [ -L $dir/$i ]; then
#    echo "rm $oldFile"
#    echo "create symlink $filename"
#    echo "$now  removed $oldFile, added symlink to $latest" >> latest.log &2
#elif [ ! -L $dir/$i ]; then
#    echo "$now  $i is not a symlink, consider cleaning directory" >> latest.log &2
#    echo "create symlink $filename"
#elif [ "$filename" == $oldFile ] && [ -L $dir/$i ]; then
#    echo "remove $oldFile"
#    echo "create symlink $filename"
#    echo "$now  Filenames match, removed $oldFile, added symlink to $latest" >> latest.log &2
#else
#    echo "create symlink $filename"
#    echo "$now  something else happened, added symlink to $latest" >> latest.log &2
#fi

}
