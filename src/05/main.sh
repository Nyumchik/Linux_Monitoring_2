#!/bin/bash

if [[ $# != 1 ]] || [[ ! $1 =~ ^[1-4]$ ]]
then
	echo -e "Wrong args"
	exit 1
fi
for (( i=1; i<6; i++))
do
    if ! [ -f ../04/$i.log ]
    then
	    echo "No log files"
	    exit 1
    fi
done

. ./monitoring.sh

if [[ $1 == 1 ]]
then
    sort_by_code
elif [[ $1 == 2 ]]
then
    all_uniq_ip
elif [[ $1 == 3 ]]
then
    errors_requests
elif [[ $1 == 4 ]]
then
    errors_uniq_ip
fi
