#!/bin/bash

clear

OFS=$IFS
IFS=','

#locked_files_list="/home/damko/locked_files.txt"

#${file} is the absolute path of the file
for file in ${@}
do
    unlock.sh "${file}"
#     echo "Unlocking ${file}"

#     sudo chattr -R -i ${file}

#     if [ "${?}" == "0" ]; then

#         # updates GIOVFS (removes the emblem)
#         gvfs-set-attribute -t stringv ${file} metadata::emblems ""

#         if [ -d ${file} ]; then
#             IFS='
# '
#             for item in $(ls -1 ${file})
#             do
#                 filename="${file}/${item}"
#                 gvfs-set-attribute -t stringv ${filename} metadata::emblems ""
#             done
#             IFS=','
#         fi

#         # takes note of the changed status
#         sudo chattr -a ${locked_files_list}
#         line=$(cat locked_files.txt | grep -x -n ${file} | cut -d: -f1 | head -n 1)
#         sed -e "${line}d" -i ${locked_files_list}
#         sudo chattr +a ${locked_files_list}

#         echo "Unocking ${file} successful"
#     else
#         # updates GIOVFS (adds the emblem)
#         gvfs-set-attribute -t stringv ${file} metadata::emblems "emblem-important"

#         if [ -d ${file} ]; then
#             IFS='
# '
#             for item in $(ls -1 ${file})
#             do
#                 filename="${file}/${item}"
#                 gvfs-set-attribute -t stringv ${filename} metadata::emblems "emblem-important"
#             done
#             IFS=','
#         fi

#         echo "Unlocking ${file} failed"
#         exit 1

#     fi
done

#refresh nemo
xdotool key Ctrl+r

IFS=$OFS
