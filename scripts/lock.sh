#!/bin/bash

clear

OFS=$IFS
IFS=','

# locked_files_list="${HOME}/locked_files.txt"
# sudo chattr -i -a ${locked_files_list}

#${file} is the absolute path of the file
for file in ${@}
do
    lock.sh "${file}"
#     # updates GIOVFS (adds the emblem)
#     gio set -t stringv ${file} metadata::emblems "changes-prevent-symbolic"

#     if [ -d ${file} ]; then
#         IFS='
# '
#         for item in $(ls -1 ${file})
#         do
#             filename="${file}/${item}"
#             gio set -t stringv ${filename} metadata::emblems "changes-prevent-symbolic"
#         done
#         IFS=','
#     fi
    
#     sudo chattr -R +i "${file}"
#     if [ "${?}" == "0" ]; then
#         # takes note of the changed status
#         cat ${locked_files_list} | grep -x "${file}" &> /dev/null
#         if [ "${?}" != "0" ]; then
#             echo "${file}" >> ${locked_files_list}
#         fi

#     else
#         # updates GIOVFS (removes the emblem)
#         gio set -t stringv ${file} metadata::emblems ""

#         if [ -d ${file} ]; then
#             IFS='
# '
#             for item in $(ls -1 ${file})
#             do
#                 filename="${file}/${item}"
#                 gio set -t stringv ${filename} metadata::emblems ""
#             done
#             IFS=','
#         fi

#         exit 1
#     fi
done

# refreshes nemo
xdotool key Ctrl+r

# sudo chattr +a ${locked_files_list}
IFS=$OFS
