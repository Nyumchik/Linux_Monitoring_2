#!/bin/bash

files=$(find ../04 -name "*.log")

sort_by_code () {
    awk '{ print $0 }' $files | sort -k 9 > sort_by_code.txt
}

all_uniq_ip () {
    awk '{ print $0 }' $files | sort -k 1 -nu > all_uniq_ip.txt
}

errors_requests () {
    awk '{ if ($9 >= 400) print $0 }' $files | sort -k 9  > errors_requests.txt
}

errors_uniq_ip () {
    awk '{ if ($9 >= 400) print $0 }' $files | sort -k 1 -nu > errors_uniq_ip.txt
}