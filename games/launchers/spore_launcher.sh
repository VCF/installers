#!/bin/bash

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_spore_collection_*.exe'

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
WINETARGET="DID NOT RECORD"
## Switches passed to Wine when running application
WINEARGS="-safe"
## Any winetricks that might be needed:
## INSTTRICKS="DID NOT RECORD"

# https://appdb.winehq.org/objectManager.php?sClass=version&iId=13652&iTestingId=31418#viewHowTo

find_and_run_executable "$@"
