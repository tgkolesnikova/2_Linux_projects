#!/bin/bash

START_TIME=$(date "+%s")

if [[ $# -ne 1 ]]; then
    echo "This script needs one parametr. Try again."
    echo "Aborted..."
    exit 1
fi

mydir=$1
if [[ !(-d "$mydir") ]]
then
    echo "The '$mydir' directory does not exists. Try again." 
    echo "Aborted..."
    exit 1
fi

list_of_mydir=$(ls -RlS $mydir > temp.txt)

# Total number of folders
dir_count=$(grep -i -o total temp.txt | wc -l)

# Total number of files
file_count=0

# Number of different types files 
conf_count=0
text_count=0
exe_count=0
log_count=0
archive_count=0
symb_count=0

IFS=$'\n'
for file in $(cat temp.txt | awk '{print $9}')
do
    if [[ -f $file ]]; then
       file_count=$(( $file_count + 1 ))
       if [[ $file == *".conf"* ]]; then
           conf_count=$(( $conf_count + 1 ))
       fi
       if [[ $$file == *".log"* ]]; then
           log_count=$(( $log_count + 1 ))
       fi
       if [[ $(file $file) == *"ASCII text"* ]]; then
           text_count=$(( $text_count + 1 ))
       fi
       if [[ $(file $file) == *"archive"* ]]; then
           archive_count=$(( $archive_count + 1 ))
       fi
    fi
    if [[ -x $file ]]; then
       exe_count=$(( $exe_count + 1 ))
    fi
    if [[ -h $file ]]; then
       symb_count=$(( $symb_count + 1 ))
    fi
done

echo "Total number of folders (including all nested ones) = $dir_count"

echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
mylist=$(ls -lR $mydir | grep ^d | sort -k5n > temp.txt)
mylist=$(tac temp.txt | sed -n 1,5p)
i=1
for line in $mylist
do
    str=$(echo $line | awk '{print $9", "$5}')
    echo "$i - $str"
    i=$(( $i + 1 ))
done

echo "Total number of files = $file_count"

echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_count"
echo "Text files = $text_count"
echo "Executable files = $exe_count"
echo "Log files (with the extension .log) = $log_count"
echo "Archive files = $archive_count"
echo "Symbolic links = $symb_count"

echo "TOP 10 files of maximum size arranged in descending order (path, size, and type):"
mylist=$(ls -lR $mydir | grep ^- | sort -k5n > temp.txt)
mylist=$(tac temp.txt | sed -n 1,10p)
i=1
for line in $mylist
do
    str=$(echo $line | awk '{print $9", "$5}')
    echo "$i - $str"
    i=$(( $i + 1 ))
done

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
mylist=$(ls -lR $mydir | grep ^-........x | sort -k5n > temp.txt)
mylist=$(tac temp.txt | sed -n 1,10p)
i=1
for line in $mylist
do
    str=$(echo $line | awk '{print $9", "$5}')
    echo "$i - $str"
    i=$(( $i + 1 ))
done

END_TIME=$(date "+%s")
work_time=$(( $END_TIME - $START_TIME ))
echo "Script execution time (in seconds) = $work_time"

rm ./temp.txt
