#!/bin/bash

## Location of the executable:
PROGDIR="CoC Dark Corners of the Earth"
LAUNCH="CoCMainWin32.exe"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="Engine"

## Location of the installer on your file system:
INSTDIR="GOG/Call of Cthulhu"
INSTNAME='setup_call_of_cthulhu_*.exe'

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
WINETARGET="GOG Games/Call of Cthulhu"
## Any winetricks that might be needed:
INSTTRICKS="directx9_28"

## Filename of launcher icon (looks in default folders):
INSTICON="Dark Corners of the Earth.png.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/Bethesda/Call of Cthulhu"
## Flag to use if backup should use rsync rather than tar/gzip:

## Notes shown before program is executed
PRERUN="
Wine Platinum:
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=3981
Dial down mouse sensitivity ...
"

find_and_run_executable "$@"
