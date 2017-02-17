#!/bin/bash

#latestLink is used to limit the amount of files backed up daily
#on an external backup server.  The program creates a new directory,
#targets the latest modified file in the specified path, and creates
#a symbolic link in the new directory.  On the next run it will delete
#the directory and complete the process again.

#Usage latestLink.sh path/to/file newestDir systemName

#This section checks that the correct number of args are entered
if [ $# == 0 ]; then
    printf 'No arguments given, 3 expected '$#' given.\n' >&2;
    printf 'Usage: arg1 = path/to/file, arg2 = directoryName\n' >&2;
    exit 1;
elif [ $# -lt 3 ]; then
    printf 'Not enough arguments given, 3 expected '$#' given.\n' >&2;
    exit 1;
elif [ $# -gt 3 ]; then
    printf 'Too many arguments given, 3 expected '$#' given.\n' >&2;
    exit 1;
fi

#Finds latest modified file
latest=`find $1 -type f | xargs ls -tr | tail -1`

#date format YYYY-MM-DD-HH-MM-SS
now=`date +"%Y-%m-%d-%H-%M-%S"`

#unique name of system
system=$3

#change to suit naming-convention
filename="$system-backup-$now"
oldFile=`find $dir -type l -name ''$system'-backup-*'`
dir=$2
getFiles=(`ls $dir`)

echo $1
echo $dir
echo $oldFile
if [ -d "$2" ]; then
    for i in "${getFiles[@]}"
    do
        if [ "$filename" != "$oldFile" ] && [ -L $dir/$i ]; then
            echo "rm $oldFile"
            #rm $oldFile
            echo "create symlink"
            #ln -sf $latest $2/$filename
            printf ''$now'  removed '$oldFile', added symlink to '$latest'\n\n' >> latest.log
        elif [ ! -L $dir/$i ]; then
            printf ''$now'  '$i' is not a symlink, consider cleaning up directory\n\n' >> latest.log &2
            echo "create symlink"
            #ln -sf $latest $2/$filename
        elif [ "$filename" == "$oldFile" ] && [ -L $dir/$i ]; then
            echo "remove $oldFile"
            #rm $oldFile
            echo "create symlink"
            #ln -sf $latest $2/$filename
            printf ''$now'  File names match, removed '$oldFile', added symlink to '$latest'\n\n' >> latest.log &2
        else
            echo "create symlink"
            #ln -sf $latest $2/$filename
           printf ''$now'  something else happened, added symlink to '$latest'\n\n' >> latest.log &2
        fi
    done
else
    echo "mkdir $2"
    #mkdir $2
    printf ''$now'  directory '$2' created\n\n' >> latest.log
    for i in "${getFiles[@]}"
    do
        if [ "$filename" !-eq "$oldFile" ] && [ -L $dir/$i ]; then
            echo "rm $oldFile"
            #rm $oldFile
            echo "create symlink"
            #ln -sf $latest $2/$filename
            printf ''$now'  removed '$oldFile', added symlink to '$latest'\n\n' >> latest.log
        elif [ ! -L $dir/$i ]; then
            printf ''$now'  '$i' is not a symlink, consider cleaning up directory\n\n' >> latest.log &2
            echo "create symlink"
            #ln -sf $latest $2/$filename
        elif [ "$filename" -eq "$oldFile" ] && [ -L $dir/$i ]; then
            echo "rm $oldFile"
            #rm $oldFile
            echo "create symlink"
            #ln -sf $latest $2/$filename
            printf ''$now'  File names match, removed '$oldFile', added symlink to '$latest'\n\n' >> latest.log &2
        else
           echo "create symlink"
           #ln -sf $latest $2/$filename
           printf ''$now'  something else happened, added symlink to '$latest'\n\n' >> latest.log &2
        fi
    done
fi


#echo commands are for testing, delete/comment before putting into production
#if [ -d "$2" ]; then
#    echo "Directory exists. Removing $2."
#    rm -r $2
#    echo "Directory removed. Creating $2/$filename."
#    mkdir $2
#    #use with or without -f(force), add -v(verbose)for debugging
#    ln -sf $latest $2/$filename
#else
#    echo "Directory does not exist. Creating $2/$filename."
#    mkdir $2
    #use with or without -f(force), add -v(verbose)for debugging
#    ln -sf $latest $2/$filename
#fi
#exit 0
