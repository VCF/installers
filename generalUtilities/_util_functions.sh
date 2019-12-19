#!/bin/bash

## Utility function library

## Presuming this file is in the same folder as the main script, it
## can be reliably invoke from within the main script with:

# my_dir="$(dirname "$0")"
# . "$my_dir/_util_functions.sh"

## Copyright (C) 2017 Charles A. Tilford
##   Where I have used (or been inspired by) public code it will be noted

LICENSE_GPL3="

    This program is free software: you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/

"

# Using dirname for calling directory: https://stackoverflow.com/a/192305
# Sourcing script with '.' :
#   http://www.unix.com/302168850-post2.html?s=34e24e03a7ea3080fed2982f1a0f038d

## Seem to be constantly pulling up ANSI color page:
##    https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
FgBlack="30"
FgRed="31"
FgGreen="32"
FgYellow="33"
FgBlue="34"
FgMagenta="35"
FgCyan="36"
FgWhite="37"
BgBlack="40"
BgRed="41"
BgGreen="42"
BgYellow="43"
BgBlue="44"
BgMagenta="45"
BgCyan="46"
BgWhite="47"
## COLOR NOTE:
##   gnome-terminal appears to use X colors
##   kterm appears to use VGA

if [[ "$TERM" == "xterm" ]]; then
    ## This seems to discriminate between konsole ('xterm') and
    ## gnome-terminal ('xterm-256color').
    BgYellow="103" # Fix ugly yellow background
fi

function ansiStart {
    echo -e "\033[1;${1}m"
}

function ansiEnd {
    echo -e "\033[0m"
}

function msg {
    ## Colorized terminal message.
    COL=$1 # The ANSI color code(s)
    MSG=$2 # The text to print
    [[ -z "$COL" ]] && col="32"
    >&2 echo -e "$(ansiStart "$COL")${MSG}$(ansiEnd)";
}

function err {
    ## Red on yellow, execution continues
    ##  $1 - The text to print
    msg "$BgYellow;$FgRed" "$1"
}

function die {
    ## Yellow on red, halts
    ##  $1 - The text to print
    msg "$BgRed;$FgYellow" "$1"
    exit
}

function set_title {
    ## Change title of terminal window header
    ##   https://unix.stackexchange.com/a/11230
    ##  $1 - The title to show
    echo -ne "\033]0;$1\007";
}

function setTilda {
    ## Just swaps values, by default replaces $HOME with '~'
    txt=$1         # The text to modify
    in=${2:-$HOME} # The value to replace
    out=${3:-'~'}  # What it should be replaced with
    ## sed with slashes: https://unix.stackexchange.com/a/39802
    echo "$txt" | sed "s|$in|$out|"
}

function relativePath {
    ## Ok... this works great: https://unix.stackexchange.com/a/233882
    ## ... but Mint 13 Maya has only realpath version 1.16, which does
    ## not support the --relative-to parameter. So we're going to do
    ## this with regular expressions, since I don't need to "back up"
    ## (That is, one directory is a child of the other)
    BaseDir=$1 # The 'higher level' directory
    FullDir=$2 # The deeper directory (child of BaseDir)
    ## Make sure directories ends with a slash
    ##   Glob pattern matching: https://stackoverflow.com/a/44688520
    [[ ! "$BaseDir" == *,/$,* ]] && BaseDir="$BaseDir"/
    [[ ! "$FullDir" == *,/$,* ]] && FullDir="$FullDir"/
    ## With realpath: realpath --relative-to="$BaseDir" "$FullDir"
    rv=`echo "$FullDir" | sed "s|$BaseDir||"`
    [[ "$rv" == "" ]] && rv='.'
    echo "$rv"
}

function hasParam {
    ## Uppercasing variables: https://stackoverflow.com/a/19411918
    PARAM=${1^^} # The parameter settings that were provided
    VAL=${2^^}   # The value to check against
    [[ "$PARAM" == *"$VAL"* ]] && echo "$VAL"
}
