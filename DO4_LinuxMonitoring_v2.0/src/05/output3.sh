#!/bin/bash

# Все запросы с ошибками (код ответа - 4хх или 5хх)

for (( i = 0; i < 5; i++ )); do
    file="../04/access_log$i"
    echo -e "\n"$file
    awk '{print $0 | "grep -e [4-5][0-9][0-9]"}' $file
done
