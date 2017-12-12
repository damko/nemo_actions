#!/bin/bash

# This scripts remove EXIF tags from pictures and resizes them
# for a safer and faster sharing

clear

OFS=$IFS
IFS=','

tmp_dir="/tmp/$(date +%s)"
dest_dir="${HOME}/dropdir"

mkdir ${tmp_dir}

#${file} is the absolute path of the file
for file in ${@}
do
	exiftool -o ${tmp_dir} -all= ${file}
done
cd ${tmp_dir}
mogrify -resize 50% *
mv * "${dest_dir}/"

rm -fR ${tmp_dir}

IFS=$OFS
