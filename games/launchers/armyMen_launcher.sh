#!/bin/bash

## Notes shown before program is executed
PRERUN="

Could not get to function under Wine

Installs and launches ok. Intro movie plays, menu music plays. Screen
is entirely black. When mouse is over menu item it highlights and can
be clicked. May be possible to get to game, but didn't devote that
much effort.

"

## Location of the executable:
PROGDIR="Army Men"
LAUNCH="Armymen.exe"
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_army_men_2.*.exe'

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
## INSTTRICKS="d3dx9_43 wmp9 wmp10"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"


find_and_run_executable "$@"
