#!/bin/bash

## Location of the executable:
PROGDIR="Iratus Lord of the Dead"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Iratus - Lord of the Dead"
INSTNAME='iratus_lord_of_the_dead_linux_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="Iratus.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Unfrozen/Iratus"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"

find_and_run_executable "$@"
