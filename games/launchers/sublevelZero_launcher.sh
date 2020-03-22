#!/bin/bash

## Location of the executable:
PROGDIR="Sublevel Zero"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_sublevel_zero_*.sh'

## Specify any required APT packages:
## Make sure a couple 32-bit packages are available:
APTPACKAGES='libxcursor1:i386 libxrandr2:i386'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/SIGTRAP Games/SublevelZero"

## Identical problem on a different game (core dump on Unity import of
## game controller config) where the program wasn't finding local
## 32-bit libraries

## https://steamcommunity.com/app/416770/discussions/0/492379439687359165/?ctp=2#c492379439688639977
export LD_LIBRARY_PATH=. %command%

find_and_run_executable "$@"
