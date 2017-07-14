#!/bin/bash

# These functions are imported using pseudo-relative pathname via dirname :
#   https://stackoverflow.com/a/192305
# ... and then are brought in by the calling script with '.' :
#   http://www.unix.com/302168850-post2.html?s=34e24e03a7ea3080fed2982f1a0f038d

# Presuming this file is in the same folder as the main script, it can
# be reliably invoke from within the main script with:

# my_dir="$(dirname "$0")"
# . "$my_dir/_util_functions.sh"


function msg {
    ## Colorized terminal message
    ## https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
    >&2 echo -e "\033[1;$1m$2\033[0m";

}

function err {
    ## Red on yellow, execution continues
    msg "43;31" "$1"
}

function die {
    ## Yellow on red, halts
    msg "41;33" "$1"
    exit
}

function set_title {
    ## Change title of terminal
    echo -ne "\033]0;$1\007";
}
