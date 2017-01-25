#!/bin/bash

clear

OFS=$IFS
IFS=','

# TEST
# for file in ${@}
# do
#     echo "file: ${file}"
# done

OUTPUT=''

#${file} is the absolute path of the file
for file in ${@}
do

    if [ -d ${file} ]; then
        echo "${file} is a directory"
        continue
    fi

    # The file extension must be "md5sum"
    extension=$(echo "${file}"|rev|cut -d. -f1|rev)
    if [ "${extension}" != "md5sum" ]; then
        continue
    fi

    # There must be a file with the same name of the .md5sum file
    # but without the trailing .md5sum, like:
    # a.txt is origin for a.txt.md5sum
    origin=$(echo "${file}"|sed "s/\.${extension}//g")

    if [[ ! -f ${origin} ]]; then
        OUTPUT="MISSING - ${origin} \n${OUTPUT}"
        continue
    fi

    # Compares the asserted checksum (contained in the md5sum file)
    # with the current checksum of the origin file
    origin_cksm=$(md5sum ${origin} | awk '{print $1}')
    stored_cksm=$(cat ${file})
    if [ "${origin_cksm}" == "${stored_cksm}" ]; then
        OUTPUT="NO CHANGE - ${origin} \n${OUTPUT}"
    else
        OUTPUT="ALTERED - ${origin} \n${OUTPUT}"
    fi
done

IFS=$OFS

zenity --info --title="MD5 verification" --text="${OUTPUT}"
