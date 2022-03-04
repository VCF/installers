#!/bin/bash

## Location of the executable:
PROGDIR="Bionic Dues"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='bionic_dues_*.tar.gz'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/game/RuntimeData/Save"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"
## Some configuration at:
##  $HOME/.config/unity3d/Arcen Games, LLC/Bionic Dues

find_and_run_executable "$@"
