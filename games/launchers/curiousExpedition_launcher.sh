#!/bin/bash

## Location of the executable:
PROGDIR="The Curious Expedition"
LAUNCH="start.sh"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='the_curious_expedition_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/The Curious Expedition"

find_and_run_executable "$@"
