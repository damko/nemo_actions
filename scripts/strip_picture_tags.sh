#!/bin/bash

# This scripts remove EXIF tags from pictures and resizes them
# for a safer and faster sharing

clear

OFS=$IFS
IFS=','

#${file} is the absolute path of the file
for file in ${@}
do
	exiftool -overwrite_original_in_place -P -all= ${file}
done

IFS=$OFS
