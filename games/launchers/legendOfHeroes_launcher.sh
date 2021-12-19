#!/bin/bash

## Location of the executable:
PROGDIR="Legend of Heroes"
LAUNCH="Config.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_the_legend_of_heroes_trails_in_the_sky_*.exe'

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
WINETARGET="GOG Games/The Legend of Heroes - Trails in the Sky"
## Any winetricks that might be needed:
INSTTRICKS="quartz amstream"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Saved Games/FALCOM/ED6"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:

## Notes shown before program is executed
PRERUN="
Wine Gold:
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=35267

During initial configuration, you will probably need to turn off movies.
They appear to cause the game to freeze after the first animated vingette.

"

find_and_run_executable "$@"
