#!/bin/bash

## Location of the executable:
PROGDIR="Warpips"
LAUNCH="Warpips.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_warpips_*.exe'

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
WINETARGET="GOG Games/Warpips"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/AppData/LocalLow/Skirmish Mode Games/Warpips"

## Notes shown before program is executed
PRERUN="
Proton Platinum, Wine Silver in my hands
  https://www.protondb.com/app/1291010

On fanless integrated graphics system soldiers were showing up as
grey silhouettes, rest of assetts seemed to render fine
"

find_and_run_executable "$@"
