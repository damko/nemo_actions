#!/bin/bash
#
# Given a filename or a directory name it transforms it in this way: 
# 
# * lowercase
# * spaces replaced by "_"
# * removes "()"
# * removes "{}"
# * removes double quotes
# * removes punctuation
# * removes question and esclamation marks

clear

OFS=$IFS
IFS=','


#${file} is the absolute path of the file
for file in ${@}
do
    #echo "Original name ${file}"

    filename_ori=$(echo ${file}|rev|cut -d/ -f1|rev)

    # ${filename_ori,,} makes all lowercase in bash 4.0
    filename_new=$(echo ${filename_ori,,}|sed 's/ /_/g')

    filename_new=$(echo ${filename_new}|sed 's/{//g'|sed 's/}//g')
    filename_new=$(echo ${filename_new}|sed 's/(//g'|sed 's/)//g')
    filename_new=$(echo ${filename_new}|sed 's/_-_/-/g')

    # double quotes
    filename_new=$(echo ${filename_new}|sed 's/\"//g')

    # punctuation
    filename_new=$(echo ${filename_new}|sed 's/\://g'|sed 's/\;//g'|sed 's/\.\././g'|sed 's/\?//g'|sed 's/\!//g')

    # question and esclamation marks
    filename_new=$(echo ${filename_new}|sed 's/?//g'|sed 's/!//g')

    # gets the differences between two strings
    path_ori=$(echo ${file%"${filename_ori}"})
    file_new=${path_ori}${filename_new}
    
    #echo ${filename_new}

    if [ ! -f  ${file_new} ]; then
        mv ${file} ${file_new}
    else
        echo "${file_new} already exist"
    fi

done

IFS=$OFS

# refreshes nemo
xdotool key Ctrl+r
