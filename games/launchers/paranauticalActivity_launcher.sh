#!/bin/bash

## Location of the executable:
PROGDIR="Paranautical Activity"
LAUNCH="Paranautical Activity.x86"

## Location of the installer on your file system:
INSTDIR="IndieGameStand/$PROGDIR"
INSTNAME='ParanauticalActivityLinux_deluxe.zip'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Rename the default install directory to something else:
INSTRENAME='Linux/'$PROGDIR

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Code Avarice/$PROGDIR"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "Setting program to be executable"
    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
}

find_and_run_executable "$@"
