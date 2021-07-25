#!/bin/bash

## Location of the executable:
PROGDIR="QMapShack"
LAUNCH="whatActuallyRunsTheProgram.sh"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='QMapShack-x86_64_*.AppImage'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/QLandkarte"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
  https://github.com/Maproom/qmapshack/wiki/DocMain
  https://github.com/Maproom/qmapshack
  https://wiki.openstreetmap.org/wiki/QMapShack
"

find_and_run_executable "$@"
