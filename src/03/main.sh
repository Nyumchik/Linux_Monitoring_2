#!/bin/bash

chmod 777 clean.sh
chmod 777 clean_date.sh
chmod 777 clean_mask.sh

if [[ $# != 1 ]]
then
	echo -e "You need wright 1 arg like 1, 2 or 3"
	exit 1
fi

if [[ $1 == 1 ]]
then
    ./clean.sh
elif [[ $1 == 2 ]]
then
    ./clean_date.sh
elif [[ $1 == 3 ]]
then
    ./clean_mask.sh
else
    echo "Enter 1, 2 or 3"
fi
