#!/bin/bash

if [[ $# != 3 ]]
then
	echo -e "Wrong number of args"
	exit 1
fi

name='^[a-zA-Z]{1,7}$'
if ! [[ $1 =~ $name ]]
then
        echo "Wrong name for folders"
        exit 1
fi

name='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
if ! [[ $2 =~ $name ]]
then
        echo "Wrong name for files"
        exit 1
fi

num='^[1-9][0-9]?[0]?Mb$'
export size=${3}
if [[ !($3 =~ $num) ]]
then
	echo "$3 wrong size"
	exit 1
else
	size=$(echo $size | awk -F"Mb" '{print $1}')
fi

function check_memory {
    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
    then
        echo "Not enough disk space"
        exit 1
    fi
}