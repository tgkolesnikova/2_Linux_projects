#!/bin/bash

HOSTNAME=$(hostname)
var1="HOSTNAME = "$HOSTNAME
echo $var1

TIMEZONE=$(timedatectl | grep Time | awk '{print $3 $4 $5}')
var2="TIMEZONE = "$TIMEZONE
echo $var2

USER=$(whoami)
var3="USER = "$USER
echo $var3

OS=$(cat /etc/os-release | sed -n 1,2p)
var4="OS = "$OS
echo $var4

DATE=$(date)
var5="DATE = "$DATE
echo $var5

UPTIME=$(uptime)
var6="UPTIME = "$UPTIME
echo $var6

UPTIME_SEC=$(cat /proc/uptime | cut -d ' ' -f 1)
var7="UPTIME_SEC = "$UPTIME_SEC
echo $var7

IP=$(ip -br a show dev enp0s3 | awk '{print $3}' | cut -d '/' -f 1)
var8="IP = "$IP
echo $var8

MASK=$(ifconfig | grep $IP | awk '{print $4}')
var9="MASK = "$MASK
echo $var9

GATEWAY=$(ip r | awk '/default/{print $3}')
var10="GATEWAY = "$GATEWAY
echo $var10

RAM_TOTAL=$(free -g | grep Mem | awk '{print $2}')
var11=$(printf "RAM_TOTAL = %.3f GB \n" $RAM_TOTAL)
echo $var11

RAM_USED=$(free -g | grep Mem | awk '{print $3}')
var12=$(printf "RAM_USED = %.3f GB\n" $RAM_USED)
echo $var12

RAM_FREE=$(free -g | grep Mem | awk '{print $4}')
var13=$(printf "RAM_FREE = %.3f GB\n" $RAM_FREE)
echo $var13

SPACE_ROOT=$(df -m / | grep dev | awk '{print $2}')
var14=$(printf "SPACE_ROOT = %.2F MB\n" $SPACE_ROOT)
echo $var14

SPACE_ROOT_USED=$(df -m / | grep dev | awk '{print $3}')
var15=$(printf "SPACE_ROOT_USED = %.2f MB\n" $SPACE_ROOT_USED)
echo $var15

SPACE_ROOT_FREE=$(df -m / | grep dev | awk '{print $4}')
var16=$(printf "SPACE_ROOT_FREE = %.2f MB\n" $SPACE_ROOT_FREE)
echo $var16

echo "Write this info to the file? 'Y' or 'y' for yes"
read ans
if [[ $ans = "Y" || $ans = "y" ]]
then
    filename=$(date "+%d_%m_%y_%H_%M_%S.%3N")
    echo "Writing to file $filename..."
    echo $var1 >> $filename
    echo $var2 >> $filename
    echo $var3 >> $filename
    echo $var4 >> $filename
    echo $var5 >> $filename
    echo $var6 >> $filename
    echo $var7 >> $filename
    echo $var8 >> $filename
    echo $var9 >> $filename
    echo $var10 >> $filename
    echo $var11 >> $filename
    echo $var11 >> $filename
    echo $var12 >> $filename
    echo $var13 >> $filename
    echo $var14 >> $filename
    echo $var15 >> $filename
    echo $var16 >> $filename
    echo "Done."
else
    echo "The end."
fi
