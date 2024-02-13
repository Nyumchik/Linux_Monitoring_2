#!/bin/bash

if [[ $# != 6 ]]
then
	echo -e "Wrong number of args"
	exit 1
fi

last=$(echo $1 | tail -c 2)
if [[ $last == "/" ]] || ! [[ -d $1 ]]
then
	echo "Wrong path"
        exit 1
fi

num='^[1-9]+$'

if [[ !($2 =~ $num) ]] || [[ !($4 =~ $num) ]]
then
	echo "$2 or $4  is not a number"
	exit 1
fi

name='^[a-zA-Z]{1,7}$'
if ! [[ $3 =~ $name ]]
then
        echo "Wrong name for folders"
        exit 1
fi

name='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
if ! [[ $5 =~ $name ]]
then
        echo "Wrong name for files"
        exit 1
fi

num='^[1-9][0-9]?[0]?kb$'
export size=${6}
if [[ !($6 =~ $num) ]]
then
	echo "$6 wrong size"
	exit 1
else
	size=$(echo $size | awk -F"kb" '{print $1}')
fi

function check_memory {
    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
    then
        echo "Not enough disk space"
        exit 1
    fi
}