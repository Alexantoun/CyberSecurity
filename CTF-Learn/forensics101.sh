#!/bin/bash
# will need to download image --> https://mega.nz/#!OHohCbTa!wbg60PARf4u6E6juuvK9-aDRe_bgEL937VO01EImM7c
#Also, if using WSL need to sudo apt install dos2unix, then run: dos2unix forensics101.sh
file="9026911a-9b38-4267-80b4-9759522c7884.jfif"
if [[ -f "$file" ]]; then
    strings "$file"
else
    echo "$file file not found!"
fi
