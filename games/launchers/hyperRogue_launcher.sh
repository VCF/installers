#!/bin/bash

## Location of the executable:
PROGDIR="HyperRogue"
LAUNCH="hyperrogue"

## git repository path:
INSTGIT="git://github.com/zenorogue/hyperrogue.git"

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='
make
g++
libsdl1.2-dev
libsdl-ttf2.0-dev
libsdl-gfx1.2-dev
libsdl-mixer1.2-dev
libglew-dev'
#
## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.hyperrogue.log"

## Custom function to run after installation:
function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR"
    msg "$FgMagenta" "
Compiling $PROGDIR in '${pwd}'
"
    make
}

find_and_run_executable "$@"
