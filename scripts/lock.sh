#!/bin/bash

clear

OFS=$IFS
IFS=','

locked_files_list="${HOME}/locked_files.txt"

#${file} is the absolute path of the file
for file in ${@}
do
#    echo "Locking ${file}"

    # updates GIOVFS (adds the emblem)
    gvfs-set-attribute -t stringv ${file} metadata::emblems "emblem-important"

    if [ -d ${file} ]; then
        IFS='
'
        for item in $(ls -1 ${file})
        do
            filename="${file}/${item}"
            gvfs-set-attribute -t stringv ${filename} metadata::emblems "emblem-important"
        done
        IFS=','
    fi
    
    sudo chattr -R +i "${file}"

    if [ "${?}" == "0" ]; then
        # takes note of the changed status
        cat ${locked_files_list} | grep -x "${file}" &> /dev/null
        if [ "${?}" != "0" ]; then
            echo "${file}" >> ${locked_files_list}
        fi

 #       echo "Locking ${file} successful"
    else
        # updates GIOVFS (removes the emblem)
        gvfs-set-attribute -t stringv ${file} metadata::emblems ""

        if [ -d ${file} ]; then
            IFS='
'
            for item in $(ls -1 ${file})
            do
                filename="${file}/${item}"
                gvfs-set-attribute -t stringv ${filename} metadata::emblems ""
            done
            IFS=','
        fi
#        echo "Locking ${file} failed"
        exit 1
    fi
done

# refreshes nemo
xdotool key Ctrl+r

IFS=$OFS
