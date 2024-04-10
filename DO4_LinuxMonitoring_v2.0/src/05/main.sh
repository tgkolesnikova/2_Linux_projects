#!/bin/bash

count=$#

if [[ $count = 0 ]]; then
    echo "No parametr."
elif [[ $count > 1 ]]; then
    echo "Too many paramerts."
else
    if [[ $1 -le 0 || $1 -ge 5 ]]; then
        echo "Wrong value."
    else
        if [[ $1 -eq 1 ]]; then source "./output1.sh"; fi
        if [[ $1 -eq 2 ]]; then source "./output2.sh"; fi
        if [[ $1 -eq 3 ]]; then source "./output3.sh"; fi
        if [[ $1 -eq 4 ]]; then source "./output4.sh"; fi
    fi
fi
