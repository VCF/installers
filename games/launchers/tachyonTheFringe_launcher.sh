#!/bin/bash

## Location of the executable:
PROGDIR="Tachyon - The Fringe"
LAUNCH="Tachyon.exe"
# LAUNCH="space.exe"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_tachyon_the_fringe_*.exe'

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
WINETARGET="GOG Games/Tachyon - The Fringe"
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

## Custom function to run after installation:
#function INSTFUNCTION {
#  echo "For example, properly setting executable bits"
#  addDLC 'foobar_pro_DLC_pack_*.exe'
#}
## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

# Custom function to run each time just before running the program:
function RUNFUNCTION {
    ## Will mess up if the monitor is not already in desired
    ## resolution (via Lee Strobel at WineHQ):

    ## Capture original resolution:
    ##   https://www.xmodulo.com/how-to-find-screen-resolution-in-linux-desktop-environment.html
    nowRes=$(xrandr | grep '*' | awk '{ print $1 }')

    echo "Setting resolution to prevent issues with monitor switching"
    xrandr -s 1024x768
}

function ENDFUNCTION {
    ## When finished, restore the original resolution
    echo "Restoring original resolution"
    xrandr -s "$nowRes"
}



## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=35930

However, in my hands the initial start game UI failed to work
  ('Play' button never activated after selecting slot)
"

find_and_run_executable "$@"
