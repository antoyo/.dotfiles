#!/bin/bash

echo "Different files:"

for file in $(find . -type f\
    -not -path "./.git/*"\
    -not -path "*.swp"\
    -not -path "./apps/*"\
    -not -path "./transmission/*"\
    -not -path "./sysrq/*"\
    -not -path "./pam-gnupg/*"\
    -not -path "./xorg/*"\
    -not -path "./diff.sh"\
    -not -path "./.gitignore"\
    )
do
    home_file=${file#*/}
    home_file=${home_file#*/}
    if [ -n "$(diff $file ~/$home_file)" ]; then
        echo $file
    fi
done
