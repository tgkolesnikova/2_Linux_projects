#!/bin/bash

N=100
#--------------  split param to symbols
dkey=$1
len_symbs=${#dkey}
symbs=()
for (( i = 0; i < $len_symbs; i++ )); do
    s=${dkey:$i:1}
    symbs+=($s)
done

#-------------- calc count for repeat one symb
x=1
let count='x**len_symbs'
while [[ $count -le $N ]]; do
    let x='x+1'
    let count='x**len_symbs'
done
let y='x-1'
let z='(x-1)**len_symbs'
if [[ $(( N - z )) > 0 ]]; then y=$x; fi

#--------------- prefix
diff=0
if [[ $len_symbs -lt 5 ]]; then let diff='5-len_symbs'; fi
prefix=''
i=1
while [[ $i -le $diff ]]; do
    prefix+=${symbs[0]}
    let i='i+1'
done

#--------------- generate dirnames
names=()
for (( i = 1; i <= $y; i++ )); do
    str=''
    j=1
    while [[ $j -le $i ]]; do
        str+=${symbs[0]}
        let j='j+1'
    done
    str2=$prefix$str
    names+=($str2)
done

for (( k = 1; k < len_symbs; k++ )); do
    names2=()
    for (( i = 0; i < ${#names[@]}; i++ )); do
        for (( j = 1; j <= $y; j++ )); do
            str=''
            m=1
            while [[ $m -le $j ]]; do
                str+=${symbs[k]}
                let m='m+1'
            done
            str2=${names[i]}$str
            names2+=($str2)
        done
    done
    names=(${names2[@]})
done

dir_names=()
for (( i = 0; i < $N; i++ )); do
    dir_names+=(${names[i]}_$(date +"%d%m%y"))
done

echo '' > dirnames.txt
for (( i = 0; i < $N; i++ )); do
    echo ${dir_names[i]} >> dirnames.txt
done
