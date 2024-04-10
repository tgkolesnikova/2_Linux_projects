#!/bin/bash

N=$4
#--------------  split param5 to symbols
fkey=$5
len_fkey=${#fkey}
symbs1=()
symbs2=()
flg=0
for (( i = 0; i < $len_fkey; i++ )); do
    s=${fkey:$i:1}
    if [[ $s == . ]]; then flg=1; fi
    if [[ $flg -eq 0 ]]; then symbs1+=($s); else symbs2+=($s); fi
done

#-------------- calc count for repeat one symb in filename
x=1
len_symbs1=${#symbs1[@]}
let count='x**len_symbs1'
while [ $count -le $N ]; do
    let x='x+1'
    let count='x**len_symbs1'
done
let y='x-1'
let z='(x-1)**len_symbs1'
if [[ $(( N - z )) > 0 ]]; then y=$x; fi

#--------------- prefix filename
diff=0
if [[ $len_symbs1 -lt 4 ]]; then let diff='4-len_symbs1'; fi
prefix=''
i=1
while [[ $i -le $diff ]]; do
    prefix+=${symbs1[0]}
    let i='i+1'
done
#echo prefix $prefix

#--------------- generate filenames
names=()
for (( i = 1; i <= $y; i++ )); do
    str=''
    j=1
    while [[ $j -le $i ]]; do
        str+=${symbs1[0]}
        let j='j+1'
    done
    str2=$prefix$str
    names+=($str2)
done

for (( k = 1; k < len_symbs1; k++ )); do
    names2=()
    for (( i = 0; i < ${#names[@]}; i++ )); do
        for (( j = 1; j <= $y; j++ )); do
            str=''
            m=1
            while [[ $m -le $j ]]; do
                str+=${symbs1[k]}
                let m='m+1'
            done
            str2=${names[i]}$str
            names2+=($str2)
        done
    done
    names=(${names2[@]})
done

#---------------- file extention
len_ext=${#symbs2[@]}   # symbs2[0] == '.'
if [[ $len_ext -eq 2 ]]; then ext=${symbs2[0]}${symbs2[1]}${symbs2[1]}${symbs2[1]}; fi
if [[ $len_ext -eq 3 ]]; then ext=${symbs2[0]}${symbs2[1]}${symbs2[1]}${symbs2[2]}; fi
if [[ $len_ext -eq 4 ]]; then ext=${symbs2[0]}${symbs2[1]}${symbs2[2]}${symbs2[3]}; fi

#---------------- file names
file_names=()
for (( i = 0; i < $N; i++ ))
do
    file_names+=(${names[i]}_$(date +"%d%m%y")$ext)
done

echo '' > filenames.txt
for (( i = 0; i < $N; i++ )); do
    echo ${file_names[i]} >> filenames.txt
done
