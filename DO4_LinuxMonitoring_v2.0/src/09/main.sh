#!/bin/bash


file="./metrics/index.html"

while true; do
    #======= CPU spent in cpu-mode (sec) =========
    m1=$(head -n 1 /proc/stat | awk '{print $2}')
    res1="node_cpu_seconds_total $m1"

    echo "# HELP node_cpu_seconds_total Seconds the cpus spent in cpu-mode." > $file
    echo "# TYPE node_cpu_seconds_total counter" >> $file
    echo $res1 >> $file

    #======= MemFree (kB) ==============
    MemFree=$(head -n 2 /proc/meminfo | tail -n 1 | awk '{print $2}')
    res2="node_memory_MemFree_kbytes $MemFree"

    echo "# HELP node_memory_MemFree_kbytes Memory information field MemFree_bytes." >> $file
    echo "# TYPE node_memory_MemFree_kbytes gauge" >> $file
    echo $res2 >> $file

    #=======  Free Disk Space ==========
    m3=$(df -k / | tail -n 1 | awk '{print $4}')
    FreeDisk=$(( m3 * 1024 ))
    res3="node_filesystem_free_bytes $FreeDisk"

    echo "# HELP node_filesystem_free_bytes Filesystem free space in bytes." >> $file
    echo "# TYPE node_filesystem_free_bytes gauge" >> $file
    echo $res3 >> $file


    echo -e $res1"\n"$res2"\n"$res3

    sleep 3
done
