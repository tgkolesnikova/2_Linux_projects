#!/bin/bash


calc_time() {
    now1=$1
    location=$2
    start=$(date --date @$now1 +"%d-%b-%Y %H:%M:%S")

    end=$(date +"%d-%b-%Y %H:%M:%S")
    now2=$(date +%s --date="$end")

    time=$(( $now2 - $now1 ))
    echo -e "\n\nstart_time: $start   end_time: $end   running_time: $time sec"
    echo "start_time: $start   end_time: $end   running_time: $time sec" >> $location'/log.txt'
}


now=$(date +%s)
location=$(pwd)
file_size=$3

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

# let "file_size = ${size%'Mb'} * 1024 * 1024"
# str=''
# for (( g = 1; g < $file_size; g++ )); do str+='#'; done

#----------------- get list of dirs for clogging
dirs=()
echo $(find / -writable -type d | grep -v "bin") > dirs0.txt
sed 's/[ \t]/\n/g' dirs0.txt > dirs.txt
while IPS= read -r line; do
    dirs+=($line)
done < dirs.txt
rm dirs*.txt

#------------------ create dirs & files
echo '' > log.txt

trap "calc_time $now $location" EXIT

for (( k = 0; k < ${#dirs[@]}; k++ )); do
    path=${dirs[k]}
    for (( i = 0; i < ${#dir_names[@]}; i++ )); do
        dir_name=$path'/'${dir_names[i]}'/'
        mkdir $dir_name

        if [[ -e $dir_name ]]; then
           echo $dir_name $(date +"%d-%m-%y %H:%M:%S") >> $location'/log.txt'
           echo "$dir_name directory created successfully..."
           count=0
           cd $dir_name
            rnd=$(( $RANDOM % ${#file_names[@]} + 1 ))
            for (( j = 0; j < ${rnd}; j++ )); do
                file=${file_names[j]}
                fallocate -l $file_size $file
                size=$(wc -c $file | awk '{print $1}')
                echo $dir_name$file $(date +"%d-%m-%y %H:%M:%S") $size >> $location'/log.txt'
                echo "$file file created successfully."
                let count="count+1"

                space=$(df -h / | awk '{print $4}' | grep -e [0-9] | sed 's/[G]*$//')
                if [ $space == 1 ]; then exit $?; fi
            done
            echo "$count files created."
            cd $location
        fi
    done
done

