#!/bin/bash

count=$#

if [[ $count = 0 ]]; then
    echo "No parametr."
elif [[ $count > 1 ]]; then
    echo "Too many paramerts."
else
    if [[ $1 -le 0 || $1 -ge 4 ]]; then
        echo "Wrong value."
    else
        if [[ $1 -eq 1 ]]; then source "./clear1.sh"; fi
        if [[ $1 -eq 2 ]]; then source "./clear2.sh"; fi
        if [[ $1 -eq 3 ]]; then source "./clear3.sh"; fi
    fi
fi
