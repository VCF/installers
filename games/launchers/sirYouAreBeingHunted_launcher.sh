#!/bin/bash

## Location of the executable:
PROGDIR="Sir You are Being Hunted"
LAUNCH="sir_v1.3"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='siryoubeinghunted_linux.zip'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Rename the default install directory to something else:
INSTRENAME='linux/'$PROGDIR

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Big Robot/SirYouAreBeingHunted"

find_and_run_executable "$@"
