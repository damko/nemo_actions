#!/bin/bash
# Given a directory, recursively resizes jpg files to 1MB

for file in $(find ${1} -mindepth 1 -type f)
do
    type=$(file --mime-type ${file} | rev | cut -d/ -f1 | rev)
    #echo "${file} - ${type}"
    if [ "${type}" == "jpeg" ]; then
        convert ${file} -define jpeg:extent=1MB ${file}
    fi
done
