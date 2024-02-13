#!/bin/bash

. ./check.sh

    touch log.txt
	file_name_pattern=${5%.*}
    file_extension=${5#*.}
    file_size=${6::-2}
    p=$(pwd)

    dir_name=$3
    current_date=$(date +"%d%m%y")

    while [[ ${#dir_name} -lt 4 ]]
    do
        dir_name=$dir_name${dir_name: -1}
    done

    while [[ ${#file_name_pattern} -lt 4 ]]
    do
        file_name_pattern=$file_name_pattern${file_name_pattern: -1}
    done

    for (( i=1; i<=$2; i++ ))
    do
        check_memory
        sudo mkdir $1/$dir_name\_$current_date
		echo $1/$dir_name\_$current_date >> log.txt
        file_name=$file_name_pattern
        for (( j=1; j<=$4; j++ ))
        do  
			check_memory
            sudo fallocate -l $file_size"KB" $1/${dir_name}_${current_date}/$file_name\_$current_date\.$file_extension
            echo "$1/${dir_name}_${current_date} ${file_name}_${current_date}.${file_extension} $(date +"%d.%m.%y") ${file_size}kb" >> $p/log.txt
			file_name=$file_name${file_name: -1}
        done
        dir_name=$dir_name${dir_name: -1}
    done
