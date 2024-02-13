#!/bin/bash

response_code=( 200 201 400 401 403 404 500 501 502 503 )
methods=( GET POST PUT PATCH DELETE )
dates="$(date "+%Y-%m-%d") 00:00:00 $(date +%z)"
url=( /home /catalog /delivery /contacts /support )
agents=( "Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool" )

for (( i=1; i<6; i++))
do
    entries=$(shuf -i 100-1000 -n 1)
    sec=$(shuf -i 10-60 -n1)
    for (( j = 0; j < $entries; j++ ))
    do
        log_ip="$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255).$(shuf -n1 -i 1-255)"
        log_response="$(shuf -e -n 1 "${response_code[@]}")"
        log_method="$(shuf -e -n 1 "${methods[@]}")"
        log_date="[$(date -d "$dates + $sec sec"  +'%d/%b/%Y:%H:%M:%S %z')]"
        log_url="$(shuf -e -n 1 "${url[@]}")"
        log_agent="$(shuf -e -n 1 "${agents[@]}")"
        echo "$log_ip - - $log_date \"$log_method / HTTP/1.1\" $log_response - \"${log_url}\" \"${log_agent}\"" >> "${i}.log"
        (( sec+=$(shuf -i 10-60 -n1) ))    
    done
    dates="$(date -d "$time + $i days" +'%Y-%m-%d')" 
done