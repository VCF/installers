#!/bin/bash

## Location of the executable:
PROGDIR="Dungeons of Dredmor"
LAUNCH="Dredmor-amd64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='dungeons-of-dredmor_*_all.tar.gz'
## Installation post-processing:
INSTRENAME='dredmor/'"$PROGDIR"
INSTSAVEDIR="$HOME/.local/share/Dredmor"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Need to find local libraries:
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GAMEDIR/$PROGDIR/amd64/"

find_and_run_executable "$@"

