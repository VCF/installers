#!/bin/bash

## Location of the executable:
PROGDIR="Ironcast"
LAUNCH="Ironcast.x86"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Linux.zip'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Rename the default install directory to something else:
INSTRENAME='Linux/'$PROGDIR

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/.config/unity3d/Ironcast"

find_and_run_executable "$@"
