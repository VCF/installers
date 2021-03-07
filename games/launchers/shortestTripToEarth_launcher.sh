#!/bin/bash

## Location of the executable:
PROGDIR="Shortest Trip to Earth"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='shortest_trip_to_earth_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Interactive Fate/Shortest Trip To Earth"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Notes shown before program is executed
PRERUN="
Minor graphics glitches that appear associated with explosions.
Otherwise runs fine
"

find_and_run_executable "$@"
