#!/bin/bash

## Location of the executable:
PROGDIR="X-COM UFO Defense"
PROGSUBDIR="DOSBOX"
LAUNCH="DOSBox.exe"
DOSBOX='-conf ../dosbox_xcomud.conf -conf ../dosbox_xcomud_single.conf -fullscreen -noconsole -c exit'

## Location of the installer on your file system:
INSTDIR="GOG/X-COM"
INSTNAME='setup_xcom_ufo_defense_*.exe'

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

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

find_and_run_executable "$@"
