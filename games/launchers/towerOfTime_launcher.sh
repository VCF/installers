#!/bin/bash

## Location of the executable:
PROGDIR="Tower of Time"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='tower_of_time_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Event horizon/Tower of Time"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

find_and_run_executable "$@"
