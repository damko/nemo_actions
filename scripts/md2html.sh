#!/bin/bash

clear

destination_dir='/home/damko/printed/html'
css_dir='/home/damko/applications/markdown-css'
css_file='github.css'
zenity_text=''

OFS=$IFS
IFS=','

#${file} is the absolute path of the file
for file in ${@}
do

    origin=$(echo ${file}|rev|cut -d/ -f1|rev)
    origin_name=$(echo ${origin}|cut -d. -f1)

    destination_name="${origin_name}.htm"
    destination_file="${destination_dir}/${destination_name}"

    pandoc -f markdown ${file} -t html5 --css=${css_dir}/${css_file} --highlight-style=haddock --self-contained --smart -o ${destination_file}

    if [ "${?}" == "0" ]; then
        echo "Success. File: ${destination_file}"
        zenity_text="${zenity_text}\n- <a href=\"file://${destination_file}\">${destination_name}</a>"
    else
        echo "Failure for: ${origin}"
        zenity_text="${zenity_text}\nFAILED: ${origin_name}"
    fi

done

IFS=$OFS

zenity --info --title="Markdown conversion" --text="${zenity_text}"