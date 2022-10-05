#!/bin/bash

## Location of the executable:
PROGDIR="Close Combat 2 Brige Too Far"
LAUNCH="cc2.exe"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/Close Combat Caen"
INSTNAME='setup_close_combat_2_*.exe'

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
WINETARGET="GOG Games/Close Combat 2"
## Any winetricks that might be needed:
## INSTTRICKS="d3dx9_43 wmp9 wmp10"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

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
#  echo "For example, configuring the system in some way"
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
Wine Garbage
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=6369&iTestingId=91921

Used Wine's Linux-native RegEdit, but could not find the predicted key:

  HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Games\Close Combat\2.00

Executable complains about not finding expected registry keys.
This is probably fixable, but not working on it at the moment

"

msg "$FgRed" "

$PRERUN

"

exit

find_and_run_executable "$@"
