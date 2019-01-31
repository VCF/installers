#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Location of the executable:
PROGDIR="Rebel Galaxy"
LAUNCH="RebelGalaxyGOG.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_rebel_galaxy_*.exe'

## Wine configuration:
wineBits="32"
export WINEPREFIX="$HOME/Wine$wineBits"
export WINEARCH="win$wineBits"
WINETARGET="GOG Games/Rebel Galaxy"
## Library mfc110u.dll not found
##   https://www.winehq.org/pipermail/wine-bugs/2014-July/391672.html
##   Eh.  I think this is because I accidently ran in a 64-bit prefix
# INSTTRICKS="vcrun2012"

## Installation post-processing:
INSTSAVEDIR="$HOME/Documents/My Games/Double Damage Games/RebelGalaxy"

INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=32788

If music is playing, be patient and wait for game to load
"

function INSTFUNCTION {
    ## From WineHQ commentary:
    echo "Please change the renderer:
  From: Direct3D 11
    To: OpenGL

If using an Nvidia card, also change Shadow Quality to Medium
"
    wineDriveC
    
    wine "$cDrive/$WINETARGET/GoGLauncher.exe"
}

find_and_run_executable "$@"
