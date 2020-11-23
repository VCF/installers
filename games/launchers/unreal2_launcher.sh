#!/bin/bash

## Location of the executable:
PROGDIR="Unreal 2 - The Awakening"
LAUNCH="Unreal2.exe"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="singleplayer/System"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_unreal_2_-_the_awakening_special_edition_*.exe'

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
WINETARGET="GOG Games/$PROGDIR"
## Any winetricks that might be needed:
## INSTTRICKS="d3dx11_43"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"


## Notes shown before program is executed
PRERUN="
COULD NOT GET TO FUNCTION
Supposedly Wine Gold:
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=7088

Crashes after trying to start a new game
"

find_and_run_executable "$@"
