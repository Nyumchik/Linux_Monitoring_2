#!/bin/bash

if ! [ -f ../02/log.txt ]
then
	echo "No log file"
	exit 1
fi

for i in $(cat ../02/log.txt)
do
	sudo rm -rf $i
done
	