#!/bin/bash

chmod 777 gen_index.sh

if [[ $# != 0 ]]
then
	echo -e "Wrong args"
	exit 1
fi

while sleep 3
do
	./gen_index.sh > my_index.html
	sudo cp my_index.html /usr/share/nginx/html/
done