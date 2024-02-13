#!/bin/bash

if [[ $# != 0 ]]
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

goaccess ../04/*.log --log-format=COMBINED > index.html