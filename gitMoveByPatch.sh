#!/bin/bash

## Move a part of a repo to another one while preserving history, as
## described by @Smar : https://stackoverflow.com/a/11426261

## $1 - The 'source' directory or file you wish to bundle up
## $2 - The path to the patch file you wish to write

## For example, if you are inside a git repository, running:
##   gitMoveByPatch.sh  "moose files/antlers" ~/moosePatch
## ... would wrap up all the files in "moose files/antlers" AND THEIR
## HISTORY, and would save them as a diff patch in ~/moosePatch. If
## you then cd'ed to a different repository, and ran:
##   git am < ~/moosePatch
## ... it would import all the files, plus their change history

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

## Source in utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_util_functions.sh"


Folder="$1"
Dest="$2"

if [[ -z "$Folder" ]]; then
    msg "33" "Please provide the git file or folder you wish to move as first argument"
    exit
fi

if [[ -z "$Dest" ]]; then
    msg "33" "Please provide a filename for the patch as second argument"
    exit
fi

if [[ -s "$Dest" ]]; then
    ## The destination exists, move it to another file path
    bkup="$Dest"-BKUP
    msg "36" "
Destination file exists: $Dest
               Moved to: $bkup
"
    mv "$Dest" "$bkup"
    ## (of course, if -BKUP already existed, we just nuked it)
fi

## About to change directory, so make sure we have absolute path of
## both source and destination:
AbsFolder=`readlink -f "$Folder"`
AbsDest=`readlink -f "$Dest"`
fDir=`dirname "$AbsFolder"`

## git appears to be unhappy if you're not in the repo that holds $Folder

cd "$fDir"

git log \
    --pretty=email \
    --patch-with-stat \
    --reverse \
    --full-index \
    --binary \
    -- "$AbsFolder" > "$AbsDest"

if [[ -s "$AbsDest" ]]; then
    msg "35" "Now cd to the 'recipient' repository, and run:
  git am < \"$AbsDest\"
"
else
    msg "31" "
Operation failed? Could not find destination file:
  $AbsDest
"
fi
