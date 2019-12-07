#!/bin/bash

## Location of the executable:
PROGDIR="Sproggiwood"
LAUNCH="Sproggiwood.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Sproggiwood_*_Linux.zip'
## Installation post-processing:
INSTRENAME='Linux/'"$PROGDIR"
INSTSAVEDIR="$HOME/.config/unity3d/Freehold\ Games/Sproggiwood"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Need to find local libraries:
## export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GAMEDIR/$PROGDIR/amd64/"

find_and_run_executable "$@"

