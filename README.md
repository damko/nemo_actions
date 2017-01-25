# Nemo actions

Some simple Nemo actions doing the following activities:

* lock / unlock a file[s] or dir[s] with chattr
* convertion of a markdown file[s] to html
* convertion of a markdown file[s] to pdf
* file[s] hashing (md5sum)
* file[s] hashing checking (md5sum) to find differences
* recursively sets standard permission for document folders
* normalizes filenames in file[s] and directory[s]

## Installation

    git clone git@github.com:damko/nemo_actions.git

Edit every single .nemo_action file and set `Active=false` to the actions that you don't want to use.

**Also be sure to read the scripts/*.sh to understand what they do before using them.**

    cp -R nemo_actions/* .local/share/nemo/actions/
    nemo -q
    nemo