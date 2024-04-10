#!/bin/bash

count=$#

if [[ $count = 0 ]]; then
    echo "No parametrs."
elif [[ $count < 6 ]]; then
    echo "Too few parametrs."
elif [[ $count > 6 ]]; then
    echo "Too many parametrs."
else
    size=$6
    if [[ $2 -eq 0 || $4 -eq 0 || ${size%'kb'} -eq 0 || ${size%'kb'} -gt 100 ]]
    then
        echo "Wrong value"
    else
        if [[ -e $1 ]]; then
           source "./gen_dirnames.sh"
           source "./gen_filenames.sh"
           source "./make_dirs.sh"
        else
           echo "This directory does not exist."
        fi
    fi
fi
