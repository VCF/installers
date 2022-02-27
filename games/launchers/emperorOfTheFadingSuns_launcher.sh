#!/bin/bash

## Location of the executable:
PROGDIR="Emperor of the Fading Suns"
LAUNCH="EFS.exe"

## Location of the installer on your file system:
INSTDIR="GOG/Emporer of the Fading Suns"
INSTNAME='setup_emperor_of_the_fading_suns_*.exe'

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
WINETARGET="GOG Games/Emperor of the Fading Suns"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/SAV"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=7324
"

find_and_run_executable "$@"
