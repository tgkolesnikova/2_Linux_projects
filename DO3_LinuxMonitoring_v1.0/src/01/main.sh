#!/bin/bash

count=$#

if [[ $count > 1 ]]
then
    echo "Too many parametrs."
elif [[ -n $1 ]]
then
    echo "Check number or string..."
    if [[ $1 == *[^0-9]* ]]
    then
        echo "Parametr: " $1
        echo "Ok."
    else
        echo "Error: Incorrect input."
    fi
else
    echo "No parametrs found."
fi