#!/bin/bash

clear

if [ -f ${HOME}/.vars ]; then
    . ${HOME}/.vars
fi

if [ ! ${MYGPGID} ]; then
	echo "Please set MYGPGID in your environment"
	exit 1
fi

OFS=$IFS
IFS=','

#${file} is the absolute path of the file
for file in ${@}
do

    if [ -d ${file} ]; then
	echo "${file} is a directory: skipped"
	continue
    fi

    #unlock gpg file if already exists
    if [ -f "${file}.gpg" ];then
	    chattr -R -i "${file}.gpg"
    fi

    gpg --batch --yes --encrypt -r ${MYGPGID} --output "${file}.gpg" ${file}
    if [ "$?" == "0" ]; then
	    chattr -R +i "${file}.gpg"
	    rm "${file}"
    fi
done

IFS=$OFS

exit 0
