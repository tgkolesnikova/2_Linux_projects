#!/bin/bash

count=$#
size=$3
if [[ $count = 0 ]]; then
    echo "No parametrs."
elif [[ $count < 3 ]]; then
    echo "Too few parametrs."
elif [[ $count > 3 ]]; then
    echo "Too many parametrs."
else
    if [[ $2 == "." || ${size%'Mb'} -le 0 || ${size%'Mb'} -gt 100 ]]
    then
        echo "Wrong value"
    else
        source "./gen_dirnames.sh"
        source "./gen_filenames.sh"
        source "./make_dirs.sh"
    fi
fi
