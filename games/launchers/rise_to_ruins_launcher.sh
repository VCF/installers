#!/bin/bash

## Location of the executable:
PROGDIR="Rise to Ruins"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='rise_to_ruins_english_*.sh'

## Rename the default install directory to something else:
## INSTRENAME='NameAfterUnpacking/'$PROGDIR
INSTRENAME="$PROGDIR"' English/'"$PROGDIR"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Programs/$PROGDIR/game/profiles"

find_and_run_executable "$@"
