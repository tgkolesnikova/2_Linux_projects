#!/bin/bash

# Все уникальные IP, которые встречаются среди ошибочных запросов

for (( i = 0; i < 5; i++ )); do
    file="../04/access_log$i"
    echo -e "\n"$file
    awk '{print $0 | "grep -e [4-5][0-9][0-9]"}' $file  | awk '{print $1,$2 | "sort -nu"}'
done
