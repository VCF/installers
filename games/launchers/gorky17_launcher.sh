#!/bin/bash

## Location of the executable:
PROGDIR="Gorky 17"
LAUNCH="gorky17.exe"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_gorky_17_*.exe'

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
WINETARGET="GOG Games/Gorky17"
## Any winetricks that might be needed:
INSTTRICKS="wmp10"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of savefiles
INSTSAVEDIR="$GAMEDIR/$PROGDIR/savegame"

## Custom function to run each time just before running the program:
function RUNFUNCTION {
    ## Will mess up if the monitor is not already in desired
    ## resolution (via Lee Strobel at WineHQ):
    ##   https://appdb.winehq.org/objectManager.php?sClass=version&iId=40358

    ## Capture original resolution:
    ##   https://www.xmodulo.com/how-to-find-screen-resolution-in-linux-desktop-environment.html
    nowRes=$(xrandr | grep '*' | awk '{ print $1 }')

    echo "Setting resolution to prevent crash"
    xrandr -s 640x480
}

function ENDFUNCTION {
    ## When finished, restore the original resolution
    echo "Restoring original resolution"
    xrandr -s "$nowRes"
}

## Notes shown before program is executed
PRERUN="
Various Wine attempts:
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=5185
"

find_and_run_executable "$@"
