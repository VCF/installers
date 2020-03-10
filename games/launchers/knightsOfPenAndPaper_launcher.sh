#!/bin/bash

## Location of the executable:
PROGDIR="Knights of Pen and Paper"
LAUNCH="knightspp.x86"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='knightspp_linux_*.tar.gz'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Rename the default install directory to something else:
INSTRENAME='knightspp_linux_*/'$PROGDIR

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Behold Studios/Pen and Paper"

## Custom function to run after installation:
function INSTFUNCTION {
  chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
}

find_and_run_executable "$@"
