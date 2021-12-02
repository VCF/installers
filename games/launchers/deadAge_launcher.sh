#!/bin/bash

## Location of the executable:
PROGDIR="Dead Age"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='dead_age_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/SilentDreams/DeadAge"

find_and_run_executable "$@"
