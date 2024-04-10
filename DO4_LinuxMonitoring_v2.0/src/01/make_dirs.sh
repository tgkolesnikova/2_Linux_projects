#!/bin/bash

path=$1
location=$(pwd)
size=$6

dir_names=()
file_names=()

while IFS= read -r line; do
    file_names+=($line)
done < filenames.txt

while IFS= read -r line; do
    dir_names+=($line)
done < dirnames.txt

rm filenames.txt
rm dirnames.txt

let "file_size = ${size%'kb'} * 1024"
str=''
for (( k = 1; k < $file_size; k++ )); do str+='#'; done

#------------------ create dirs & files
echo '' > log.txt
for (( i = 0; i < ${#dir_names[@]}; i++ )); do
    dir_name=$path'/'${dir_names[i]}'/'
    mkdir $dir_name
    echo $dir_name $(date +"%d-%m-%y %H:%M:%S") >> $location'/log.txt'

    if [[ -e $dir_name ]]; then
        cd $dir_name
        for (( j = 0; j < ${#file_names[@]}; j++ )); do
            file=${file_names[j]}
            echo $str > $file
            size=$(wc -c $file | awk '{print $1}')
            echo $dir_name$file $(date +"%d-%m-%y %H:%M:%S") $size >> $location'/log.txt'

            space=$(df -h / | awk '{print $4}' | grep -e [0-9] | sed 's/[G]*$//')
            if [ $space == 1 ]; then exit $?; fi
        done
        cd $location
    fi
done

#------------------ delete dirs & files (uncomment if needs)
#    rm -r $path
