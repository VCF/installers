#!/bin/bash

## Location of the executable:
PROGDIR="No Man's Sky"
LAUNCH="NMS.exe"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="Binaries"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_no_mans_sky_*.exe'

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
WINETARGET="GOG Games/$PROGDIR"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='winbind mesa-vulkan-drivers libvulkan1'

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Application Data/HelloGames/NMS"

## Custom function to run after installation:
function INSTFUNCTION {
    PDIR="$GAMEDIR/$PROGDIR/Binaries"
    GOOD="$PDIR/DO_NOT_USE_vulkan.dll"
    BAD="$PDIR/vulkan-1.dll"
    if [[ -e "$BAD" ]]; then
        mv "$BAD" "$GOOD"
        msg "$FgMagenta" "
Moved Vulkan DLL:
  From: $BAD
    To: $GOOD
"
    fi
    if [[ ! -e "$GOOD" ]]; then
        msg "$BgYellow;$FgRed" "
Failed to find properly named Vulkan DLL. It should be at:
  $GOOD
  ... but was not located.
"
        exit
    fi
}

find_and_run_executable "$@"
