#!/bin/bash

# Все уникальные IP, встречающиеся в записях

for (( i = 0; i < 5; i++ )); do
    file="../04/access_log$i"
    echo -e "\n"$file
    awk '{print $1 | "sort -nu"}' $file
done
