#!/bin/bash

## Move a part of a repo to another one while preserving history, as
## described by @Smar : https://stackoverflow.com/a/11426261

## For example, if you are inside a git repository, running:
##   gitMoveByPatch.sh  "moose files/antlers" ~/moosePatch
## ... would wrap up all the files in "moose files/antlers" AND THEIR
## HISTORY, and would save them as a diff patch in ~/moosePatch. If
## you then cd'ed to a different repository, and ran:
##   git am < ~/moosePatch
## ... it would import all the files, plus their change history

Folder="$1"
Dest="$2"

if [[ -z "$Folder" ]]; then
    echo "Please provide the git file or folder you wish to move as first argument"
    exit
fi

if [[ -z "$Dest" ]]; then
    echo "Please provide a filename for the patch as second argument"
    exit
fi

git log \
    --pretty=email \
    --patch-with-stat \
    --reverse \
    --full-index \
    --binary \
    -- "$Folder" > "$Dest"

echo "Now cd to the 'recipient' repository, and run:
  git am < \"$Dest\"
"
