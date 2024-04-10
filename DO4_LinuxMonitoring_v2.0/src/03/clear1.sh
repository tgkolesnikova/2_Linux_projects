#!/bin/bash

echo "Delete by log-file"
echo "Please, enter name of log_file"
read path

i=0
if [[ -f $path ]]; then
    while read line; do
        name=($line)
        delet=${name[0]}
        if [[ -e $delet ]]
        then
            if [[ -d $delet ]]
            then
                rm -r $delet
                echo "Dir $delet deleted."
            else
                rm $delet
                echo "File $delet deleted."
            fi
            let i="i+1"
        else
            echo "The path $delet does not exist."
        fi
    done < $path
    echo "$i objects deleted."
else
    echo "Entered wrong filename!"
fi
