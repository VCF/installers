#!/bin/bash

## Location of the executable:
PROGDIR="Galaxy of Pen and Paper"
LAUNCH="GalaxyOfPenAndPaper.x86_64"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='behold-studios-thundercats-linux-universal-no-drm-release-*.zip'

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
INSTSAVEDIR="$HOME/.config/unity3d/Behold Studios/Galaxy of Pen and Paper"

find_and_run_executable "$@"
