#!/bin/bash

. ./check.sh
    
    touch log.txt
    file_name_pattern=${2%.*}
    file_extension=${2#*.}
    file_size=${3::-2}
    p=$(pwd)

    dir_name=$1
    current_date=$(date +"%d%m%y")
    dir_num=$(echo $(( 1 + $RANDOM % 100 )))

    while [[ ${#dir_name} -lt 5 ]]
    do
        dir_name=$dir_name${dir_name: -1}
    done

    while [[ ${#file_name_pattern} -lt 5 ]]
    do
        file_name_pattern=$file_name_pattern${file_name_pattern: -1}
    done

    start_time=$(date +"%d.%m.%Y %H:%M:%S")
    TIMEFORMAT="Execution time - %lR"
    time (
    for (( i=0; i<=$dir_num; i++ ))
    do
        
        path="$(compgen -d / | shuf -n1)"
        if [[ $path == "/bin" || $path == "/sbin" || $path == "/lost+found" || $path == "/sys" || $path == "/proc" ]] 
        then
            path="/snap"
        fi
        check_memory
        sudo mkdir $path/$dir_name\_$current_date
        echo "$path/${dir_name}_${current_date} $(date +"%d.%m.%Y %H:%M:%S")" >> log.txt
        file_name=$file_name_pattern
        files_num=$(shuf -i 1-100 -n1)
        for (( j=0; j<=$files_num; j++ ))
        do  
            check_memory
            sudo fallocate -l $file_size"MB" $path/${dir_name}_${current_date}/$file_name\_$current_date\.$file_extension
            echo "$path/${dir_name}_${current_date}/${file_name}_${current_date}.${file_extension} $(date +"%d.%m.%Y %H:%M:%S") ${file_size}MB" >> $p/log.txt
			file_name=$file_name${file_name: -1}
        done
        dir_name=$dir_name${dir_name: -1}
        
    done
    finish_time=$(date +"%d.%m.%Y %H:%M:%S")
    echo "Start time - $start_time" >> log.txt
    echo "Finish time - $finish_time" >> log.txt
    ) 2>> log.txt