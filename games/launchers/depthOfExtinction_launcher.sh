#!/bin/bash

## Location of the executable:
PROGDIR="Depth of Extinction"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='depth_of_extinction_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/HOF Studios/Depth of Extinction"

find_and_run_executable "$@"
