#!/bin/bash

function main(){

$(argTest $1 $2 $3)

if [ $? == 1 ]; then
#   printf 'Failed argTest\n\n' >> latest.log &2
    exit 1
fi

echo "next step"

#Finds the latest modified file
latest=`find $1 -type f | xargs ls -tr | tail -1`

#Date format YYYY-MM-DD-HH-MM-SS
now=`date +"%Y-%m-%d-%H-%M-%S"`

#Unique name of the system
system=$3

#Change to suit naming convention
filename="$system-backup-$now"
oldFile="$(find "$dir" -type l -name ''"$system"'-backup-*')"
dir=$2
getFiles=(`ls $dir`)

if [ -d "$2" ]; then 
    for i in "${getFiles[@]}"
    do
        $(symLink $filename $latest $oldFile $dir $now)
    done
fi

}

function argTest(){

if [ $# == 0 ]; then
    printf 'No arguments given, 3 expected '$#' given.\n' >&2
    printf 'Usage: arg1 = path/to/file, arg2 = directory name, arg3 = system name\n' >&2
    exit 1
elif [ $# -lt 3 ]; then
    printf 'Not enough arguments given, 3 expected '$#' given.\n' >&2
    exit 1
elif [ $# -gt 3 ]; then
    printf 'Too many arguments given, 3 expected '$#' given.\n' >&2
    exit 1
else
    exit 0
fi

}

function symLink(){

if [ "$1" != "$3" ] && [ -L $4/$i ]; then
    echo "rm $3"
    #rm $oldFile
    echo "create symlink"
    #ln -sf $latest $2/$filename
    printf ''$5'  removed '$3', added symlink to '$2'\n\n' >> latest.log
elif [ ! -L $4/$i ]; then
    printf ''$5'  '$i' is not a symlink, consider cleaning up directory\n\n' >> latest.log &2
    echo "create symlink"
    #ln -sf $latest $2/$filename
elif [ "$1" == "$oldFile" ] && [ -L $4/$i ]; then
    echo "remove $3"
    #rm $oldFile
    echo "create symlink"
    #ln -sf $latest $2/$filename
    printf ''$5'  File names match, removed '$3', added symlink to '$2'\n\n' >> latest.log &2
else
    echo "create symlink"
    #ln -sf $latest $2/$filename
    printf ''$5'  something else happened, added symlink to '$2'\n\n' >> latest.log &2
fi

}

main $1 $2 $3
