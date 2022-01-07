#!/bin/bash

## Location of the executable:
PROGDIR="Regions of Ruin"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='regions_of_ruin_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/voxGames/Regions of Ruin"

find_and_run_executable "$@"
