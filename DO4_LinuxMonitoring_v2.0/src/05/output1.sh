#!/bin/bash

# Все записи, отсортированные по коду ответа

IFS=$'\n'
for (( i = 0; i < 5; i++ )); do
    file="../04/access_log$i"
    echo -e "\n"$file
    awk '{print $0 | "sort -n -k 2"}' $file
done
unset IFS