#!/bin/bash

## Location of the executable:
PROGDIR="Doki Doki Gravity Dive"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='doki_doki_gravity_dive_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/MemoriesIn8Bit/$PROGDIR"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"

find_and_run_executable "$@"
