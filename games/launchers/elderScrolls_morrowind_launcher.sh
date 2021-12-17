#!/bin/bash

## Location of the executable:
PROGDIR="Elder Scrolls Morrowind"
LAUNCH="Morrowind Launcher.exe"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/Elder Scrolls"
INSTNAME='setup_tes_morrowind_goty_*.exe'

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
WINETARGET="GOG Games/Morrowind"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='gstreamer1.0-plugins-good:i386'

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Saves"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=3383
"

find_and_run_executable "$@"
