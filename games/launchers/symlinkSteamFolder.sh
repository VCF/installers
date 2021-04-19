#!/bin/bash

# Script to help manage over-sized Steam games by moving them from a
# fast 'primary' disk to a slow 'overflow' disk, and creating a
# symlink back to the expected location.

# The folder you wish to move is the first argument:
SRC="$1"
# The faster, smaller disk that Steam is resident on
STEAMDIR="$HOME/.steam/steamapps/common"
# The larger, slower disk you will move to:
TARGDIR="/media/$USER/NewDisk/homeOverflow"

if [[ ! -d "$STEAMDIR" ]]; then
    echo "
I expected to find the overflow folder here, but did not:
  '$TARGDIR'
"
   exit
fi

if [[ ! -d "$STEAMDIR" ]]; then
    echo "
I expected to find your steam library directory here, but did not:
  '$STEAMDIR'
"
    exit
fi

if [[ -z "$SRC" ]]; then
    echo "
Provide the name of the steam directory you wish to move.
If it has spaces, assure the name is in quotes.
"
    exit
fi

if [[ ! -d "$SRC" ]]; then
    ## Perhaps the directory was passed as a relative name?
    TRY="$STEAMDIR/$SRC"
    if [[ -d "$TRY" ]]; then
        SRC="$TRY"
    else
        echo "
I could not find this steam directory:
  '$SRC'
"
        exit
    fi
fi

FNAME="$(basename "$SRC")"
DEST="$TARGIDR/$FNAME"
echo "Moving Steam folder
From: $SRC
  To: $DEST
      Start: $(date +'%H:%M:%S')"
mv "$SRC" "$DEST"
echo "        End: $(date +'%H:%M:%S')"

if [[ -d "$SRC" ]]; then
    echo "
Error! Source directory appears to be still in place!
  '$SRC'
"
    exit
fi

if [[ ! -d "$DEST" ]]; then
    echo "
Error! Destination directory not found!
  '$DEST'
Uncertain where folder has been moved to!
"
    exit
fi

echo "
Creating symlink in Steam folder
"

ln -s "$DEST" "$SRC"

if [[ -l "$SRC" ]]; then
    echo "   Link created."
    CHK="$(readlink -f "$SRC")"
    if [[ "$CHK" == "$DEST" ]]; then
        echo "   Link confirmed to correct target."
    else
        echo "
Error! Symlink appears to be to wrong target?
"
    fi
else
    echo "
Error! Symlink failed?
"
fi

ls -lhd "$SRC"
ls -lhd "$DEST"

echo "
Finished.
"
