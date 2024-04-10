#!/bin/bash

echo "Enter mask:"
read mask
fmask="$mask.*"
# echo $mask $fmask
find / -type f -name $fmask -delete
find / -type d -name $mask -exec rm -rf {} \;
