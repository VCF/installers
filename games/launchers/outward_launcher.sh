#!/bin/bash

## Location of the executable:
PROGDIR="Outward"
LAUNCH="Outward.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_outward_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="64"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="GOG Games/$PROGDIR"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/SaveGames"

## Notes shown before program is executed
PRERUN="
Seems to run fine, but any 'excursion' out of the program (eg alt-tab)
will cause the program to crash. Also crashes if the screen saver
activates (eg if playing by game pad and screen lock timeout occurs)
"

find_and_run_executable "$@"
