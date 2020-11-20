#!/bin/bash

## Location of the executable:
PROGDIR="Steel Storm"
LAUNCH="steelstorm64"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='steelstorm-br-*-release.tar.gz'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Rename the default install directory to something else:
INSTRENAME='steelstorm/'$PROGDIR

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.steelstorm"

find_and_run_executable "$@"
