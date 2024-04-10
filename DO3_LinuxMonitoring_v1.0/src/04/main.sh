#!/bin/bash


# Default color scheme:
column1_background=2
column1_font_color=4
column2_background=5
column2_font_color=1


# change default color or not (0 - not, 1 - yes)
flag=0


# read new colors from file 'colors.conf'
while IFS= read -r line
do
  if [[ $line != *"#"* ]]
  then
    if [[ $line == *"column1_background"* ]]; then
        column1_background=${line#*=}
        flag=1
    fi
    if [[ $line == *"column1_font_color"* ]]; then
        column1_font_color=${line#*=}
        flag=1
    fi
    if [[ $line == *"column2_background"* ]]; then
        column2_background=${line#*=}
        flag=1
    fi
    if [[ $line == *"column2_font_color"* ]]; then
        column2_font_color=${line#*=}
        flag=1
    fi
  fi
done < colors.conf


# for printf
font_colors=(0m 97m 91m 92m 94m 95m 30m)
bg_colors=(0m 107m 101m 102m 104m 105m 40m)

bg1=[${bg_colors[$column1_background]}
clr1=[${font_colors[$column1_font_color]}

bg2=[${bg_colors[$column2_background]}
clr2=[${font_colors[$column2_font_color]}

rst=[${bg_colors[0]}


# system research
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


# output color scheme

color_names=("none" "white" "red" "green" "blue" "purple" "black")

echo

if [[ flag -eq 1  ]]
then
    echo "Column 1 background = $column1_background (${color_names[$column1_background]})"
    echo "Column 1 font color = $column1_font_color (${color_names[$column1_font_color]})"
    echo "Column 2 background = $column2_background (${color_names[$column2_background]})"
    echo "Column 2 font color = $column2_font_color (${color_names[$column2_font_color]})"
else
    echo "Column 1 background = default (${color_names[$column1_background]})"
    echo "Column 1 font color = default (${color_names[$column1_font_color]})"
    echo "Column 2 background = default (${color_names[$column2_background]})"
    echo "Column 2 font color = default (${color_names[$column2_font_color]})"
fi
