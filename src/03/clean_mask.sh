#!/bin/bash

read -p "Enter mask like name_ddmmyy): " mask

check_mask='([a-zA-Z]{1,7})_([0-9]{6})$'
if ! [[ $mask =~ $check_mask ]]
then
  echo "Incorrect mask"
  exit 1
fi

name=${mask%_*}
date=${mask#*_}


sudo find / -type d -name "$name*_$date" 2>/dev/null
files="$(sudo find / -type d -name "$name*_$date" 2>/dev/null)"
read -p "Do you want to delete all these directories? (y/n): " opt
case "$opt" in 
			y|Y ) 
				for i in $files
                do
                    sudo rm -rf $i
                    
                done

                ;;
			n|N )
                read -p "Do you want to delete only our files? (y/n): " opt2
                case "$opt2" in
                y|Y )
                    ./clean.sh
                    ;;
                n|N ) 
				    exit 0
                    ;;
                * )
                    echo "Wrong opt"
				    exit 1
				    ;;
		        esac
				;;
			* ) 
				echo "Wrong opt"
				exit 1
				;;
esac
