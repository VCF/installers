#!/bin/bash

## Location of the executable:
PROGDIR="Sublevel Zero"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_sublevel_zero_*.sh'

## Specify any required APT packages:
## Tried installing 32-bit libraries one-by-one, but there are a LOT,
## apparently needed by Unity. So just install ALL of them. Will
## likely be needed for other games as well.
# APTPACKAGES='libxcursor1:i386 libxrandr2:i386'
APTPACKAGES='ia32-libs'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/SIGTRAP Games/SublevelZero"

find_and_run_executable "$@"
