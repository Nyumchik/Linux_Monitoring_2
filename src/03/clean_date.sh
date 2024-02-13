#!/bin/bash

read -p "Enter start time like yyyy-mm-dd hh-mm:" start_time
read -p "Enter end time in like yyyy-mm-dd hh-mm:" end_time

check_date='^([0-9]{4})-([0-9]{2})-([0-9]{2}) ([0-9]{2}):([0-9]{2})$'
if ! [[ $start_time =~ $check_date ]] || ! [[ $end_time =~ $check_date ]]
then
    echo "Incorrect date"
    exit 1
fi
sudo find / -type f -maxdepth 4 -newerct "$start_time" ! -newerct "$end_time" 2>/dev/null
files="$(sudo find / -type f -maxdepth 4 -newerct "$start_time" ! -newerct "$end_time" 2>/dev/null)"
read -p "Do you want to delete all these files? (y/n): " opt
case "$opt" in 
			y|Y ) 
				for i in $files
                do
                    sudo rm $i
                    num=$(sudo ls $(dirname $i) | wc -l)
                    if [[ $num == 0 ]]
                    then
                        read -p "Do you want to delete the directory $(dirname $i) where files were located? (y/n): " opt3
                        if [[ $opt3 == 'y' ]] || [[ $opt3 == 'Y' ]]
                        then
                            sudo rmdir $(dirname $i)
                        fi
                    fi
                    
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
