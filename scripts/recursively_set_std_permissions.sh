#!/bin/bash
# Given a directory tree, recursively sets dirs to 0755 and files to 0644

find ${1} -mindepth 1 -type d | xargs chmod 0755
find ${1} -mindepth 1 -type f | xargs chmod 0644
