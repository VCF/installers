#!/bin/bash

## Location of the executable:
PROGDIR="Unreal Tournament"
LAUNCH="UT2004.exe"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="System"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_ut2004_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="32"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="GOG Games/Unreal Tournament 2004"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"


## Notes shown before program is executed
#PRERUN="
#If the program asks to choose a flavor, please select 'Tepid Mango'
#"

find_and_run_executable "$@"
