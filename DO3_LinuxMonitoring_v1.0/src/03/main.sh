#!/bin/bash

count=$#
if [[ $count != 4 ]]
then
    echo "This script work with 4 params only."
    echo "Aborted..."
    exit 1
fi

if [[ $1 == *[a-zA-Z]* || $2 == *[a-zA-Z]* || $3 == *[a-zA-Z]* || $4 == *[a-zA-Z]* ]]
then
    echo "There is not a number among params."
    echo "Aborted..."
    exit 1
fi

if [[ $1 -eq $2 || $3 -eq $4 ]]
then
    echo "The font and background colors of the same column must not match."
    echo "Please, try again."
    echo "Aborted..."
    exit 1
fi

if [[ $1 -lt 1 || $1 -gt 6 || $2 -lt 1 || $2 -gt 6 ||
      $3 -lt 1 || $3 -gt 6 || $4 -lt 1 || $4 -gt 6 ]]
then
    echo "There are invalid values. Please, enter 4 numbers in range from 1 to 6."
    echo "Aborted..."
    exit 1
fi


######  Only if previos OK   #######

font_colors=(0m 97m 91m 92m 94m 95m 30m)
bg_colors=(0m 107m 101m 102m 104m 105m 40m)

bg1=[${bg_colors[$1]}
clr1=[${font_colors[$2]}

bg2=[${bg_colors[$3]}
clr2=[${font_colors[$4]}

rst=[${bg_colors[0]}

HOSTNAME=$(hostname)
printf "\033%s\033%s HOSTNAME \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $HOSTNAME $rst

TIMEZONE=$(timedatectl | grep Time | awk '{print $3 $4 $5}')
printf "\033%s\033%s TIMEZONE \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $TIMEZONE $rst

USER=$(whoami)
printf "\033%s\033%s USER \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $USER $rst

OS=$(cat /etc/os-release | sed -n 1,2p)
printf "\033%s\033%s OS \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $OS $rst

DATE=$(date)
printf "\033%s\033%s DATE \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $DATE $rst

UPTIME=$(uptime | awk '{print $1}')
printf "\033%s\033%s UPTIME \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $UPTIME $rst

UPTIME_SEC=$(cat /proc/uptime | cut -d ' ' -f 1)
printf "\033%s\033%s UPTIME_SEC \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $UPTIME_SEC $rst

IP=$(ip -br a show dev enp0s3 | awk '{print $3}' | cut -d '/' -f 1)
printf "\033%s\033%s IP \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $IP $rst

MASK=$(ifconfig | grep $IP | awk '{print $4}')
printf "\033%s\033%s MASK \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $MASK $rst

GATEWAY=$(ip r | awk '/default/{print $3}')
printf "\033%s\033%s GATEWAY \033%s=\033%s\033%s %s \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $GATEWAY $rst

RAM_TOTAL=$(free -g | grep Mem | awk '{print $2}')
printf "\033%s\033%s RAM_TOTAL \033%s=\033%s\033%s %.3f GB \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $RAM_TOTAL $rst

RAM_USED=$(free -g | grep Mem | awk '{print $3}')
printf "\033%s\033%s RAM_USED\033%s=\033%s\033%s %.3f GB \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $RAM_USED $rst

RAM_FREE=$(free -g | grep Mem | awk '{print $4}')
printf "\033%s\033%s RAM_FREE\033%s=\033%s\033%s %.3f GB \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $RAM_FREE $rst

SPACE_ROOT=$(df -m / | grep dev | awk '{print $2}')
printf "\033%s\033%s SPACE_ROOT\033%s=\033%s\033%s %.2F MB \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $SPACE_ROOT $rst

SPACE_ROOT_USED=$(df -m / | grep dev | awk '{print $3}')
printf "\033%s\033%s SPACE_ROOT_USED\033%s=\033%s\033%s %.2f MB \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $SPACE_ROOT_USED $rst

SPACE_ROOT_FREE=$(df -m / | grep dev | awk '{print $4}')
printf "\033%s\033%s SPACE_ROOT_FREE \033%s=\033%s\033%s %.2f MB \033%s\n" $clr1 $bg1 $rst $clr2 $bg2 $SPACE_ROOT_FREE $rst

