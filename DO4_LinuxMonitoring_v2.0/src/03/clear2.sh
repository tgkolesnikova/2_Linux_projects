#!/bin/bash

echo ""
echo "Please, enter date/time period (YYYY-MM-DD hh:mm)"
echo " date/time of start:"
d1=-1
while [[ $d1 -le 0 || $d1 -ge 32 ]]; do
    echo -n "                day: "
    read d1
done
m1=-1
while [[ $m1 -le 0 || $m1 -ge 13 ]]; do
    echo -n "              month: "
    read m1
done
y1=-1
while [[ ${#y1} -le 3 || ${#y1} -ge 5 ]]; do
    echo -n "               year: "
    read y1
done
h1=-2
while [[ $h1 -le -1 || $h1 -ge 24 ]]; do
    echo -n "              hours: "
    read h1
done
s1=-2
while [[ $s1 -le -1 || $s1 -ge 60 ]]; do
    echo -n "            minutes: "
    read s1
done
date1="$y1-$m1-$d1 $h1:$s1:00"

echo "   date/time of end:"
d2=-1
while [[ $d2 -le 0 || $d2 -ge 32 ]]; do
    echo -n "             day: "
    read d2
done
m2=-1
while [[ $m2 -le 0 || $m2 -ge 13 ]]; do
    echo -n "           month: "
    read m2
done
y2=-1
while [[ ${#y2} -le 3 || ${#y2} -ge 5 ]]; do
    echo -n "            year: "
    read y2
done
h2=-2
while [[ $h2 -le -1 || $h2 -ge 24 ]]; do
    echo -n "           hours: "
    read h2
done
s2=-2
while [[ $s2 -le -1 || $s2 -ge 60 ]]; do
    echo -n "         minutes: "
    read s2
done
date2="$y2-$m2-$d2 $h2:$s2:00"

find / -path "*bin*" -prune -o -type f -newermt "$date1" \! -newermt "$date2" -ls #-delete
find / -path "*bin*" -prune -o  -type d -newermt "$date1" \! -newermt "$date2" -ls #-exec rm -rf {} \;

