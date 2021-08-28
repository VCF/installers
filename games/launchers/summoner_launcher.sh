#!/bin/bash

## Location of the executable:
PROGDIR="Summoner"
LAUNCH="Summoner.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_the_summoner_*.exe'

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
WINETARGET="GOG Games/The Summoner"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"

## Notes shown before program is executed
PRERUN="
Wine Garbage:
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=30718
Confirmed Direct3D error preventing launch
"

find_and_run_executable "$@"
