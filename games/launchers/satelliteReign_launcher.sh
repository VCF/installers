#!/bin/bash

## Location of the executable:
PROGDIR="Satellite Reign"
LAUNCH="SatelliteReignLinux.x86_64"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='SatelliteReignLinux*.zip'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Parameters for archives (zip/gz):
## Define a parent directory for unpacking archives:
UNPACKDIR="$PROGDIR"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/SatelliteReign"

find_and_run_executable "$@"
