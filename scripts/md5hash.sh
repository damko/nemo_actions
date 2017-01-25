#!/bin/bash

clear

OFS=$IFS
IFS=','

#${file} is the absolute path of the file
for file in ${@}
do

    if [ -d ${file} ]; then
		echo "${file} is a directory: skipped"
		continue
    fi

      echo "Hashing ${file}"
      md5sum "${file}" | awk '{print $1}' > "${file}.md5sum"
      chmod 0550 "${file}.md5sum"
done

IFS=$OFS
