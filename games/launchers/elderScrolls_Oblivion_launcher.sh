#!/bin/bash

## Location of the executable:
PROGDIR="Elder Scrolls Oblivion"
LAUNCH="OblivionLauncher.exe"

## Location of the installer on your file system:
INSTDIR="GOG/Oblivion"
INSTNAME='setup_oblivion_*.exe'

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
WINETARGET="GOG Games/Oblivion"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/My Games/Oblivion"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=35784
  Startup videos are unskippable, trying to do so might crash game
"

find_and_run_executable "$@"
