#!/bin/bash

## Location of the executable:
PROGDIR="Caves of Qud"
LAUNCH="start.sh"

## Location of the installer:
INSTDIR="GOG/Caves of Qud"
INSTNAME='caves_of_qud_*.sh'

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Freehold Games/CavesOfQud"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"
## Notes:

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
