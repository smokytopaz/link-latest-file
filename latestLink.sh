#!/bin/bash

#Making big cahnges here

#latestLink is used to limit the amount of files backed up daily 
#on an external backup server.  The program creates a new directory,
#targets the latest modified file in the specified path, and creates
#a symbolic link in the new directory.  On the next run it will delete
#the directory and complete the process again.

#Usage latestLink.sh path/to/file newestDir

#This section checks that the correct number of args are entered
if [ $# == 0 ]; then
    printf 'No arguments given, 2 expected.\n' >&2;
    printf 'Usage: arg1 = path/to/file, arg2 = directoryName\n' >&2;
    exit 1;
elif [ $# -lt 2 ]; then
    printf 'Not enough arguments given, 2 expected.\n' >&2;
    exit 1;
elif [ $# -gt 2 ]; then
    printf 'Too many arguments given, 2 expected.\n' >&2;
    exit 1;
fi

#Finds latest modified file
latest=`find $1 -type f | xargs ls -tr | tail -1`

#date format YYYY-MM-DD-HH-MM-SS
now=`date +"%Y-%m-%d-%H-%M"`

#change to suit naming-convention
filename="backup-$now"

#echo commands are for testing, delete/comment before putting into production
if [ -d "$2" ]; then
    echo "Directory exists. Removing $2."
    rm -r $2
    echo "Directory removed. Creating $2/$filename."
    mkdir $2
    #use with or without -f(force), add -v(verbose)for debugging
    ln -sf $latest $2/$filename
else
    echo "Directory does not exist. Creating $2/$filename."
    mkdir $2
    #use with or without -f(force), add -v(verbose)for debugging
    ln -sf $latest $2/$filename
fi
exit 0
