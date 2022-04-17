#!/bin/bash

## Location of the executable:
PROGDIR="Partisans 1941"
LAUNCH="Partisans.exe"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_partisans_1941_extended_edition_*.exe'

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
WINETARGET="GOG Games/Partisans 1941"
## Any winetricks that might be needed:
## INSTTRICKS="d3dx9_43 wmp9 wmp10"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Normally a new terminal is opened to launch. Flag to prevent this:
## NOTINTERM="No launching terminal"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Custom function to run each time just BEFORE running the program:
#function RUNFUNCTION {
#}
## Custom function to run AFTER program executes
#function ENDFUNCTION {
#    ## eg clean up system after program has tinkered with it
#}
## Custom function to run after installation:
#function INSTFUNCTION {
#  echo "For example, properly setting executable bits"
#  addDLC 'foobar_pro_DLC_pack_*.exe'
#}

## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://www.protondb.com/app/1227530

Currently not working: fails to find .uproject file
"

find_and_run_executable "$@"
