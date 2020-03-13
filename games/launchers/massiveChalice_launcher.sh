#!/bin/bash

## Location of the executable:
PROGDIR="Massive Chalice"
LAUNCH="MC"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='MASSIVE_CHALICE_*_LINUX.tar.gz'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Parameters for archives (zip/gz):
## Rename the default install directory to something else:
INSTRENAME='MASSIVE_CHALICE_DRMFREE_LINUX/'$PROGDIR

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/doublefine/massivechalice"

find_and_run_executable "$@"
