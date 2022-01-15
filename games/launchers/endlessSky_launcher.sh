#!/bin/bash

## Location of the executable:
PROGDIR="Endless Sky"
LAUNCH="endless-sky"
# PROGSUBDIR="bin"

## git repository path:
INSTGIT="git://github.com/endless-sky/endless-sky.git"

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='
g++
scons
libsdl2-dev
libpng-dev
libjpeg-dev
libgl1-mesa-dev
libglew-dev
libopenal-dev
libmad0-dev
uuid-dev
'
## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/endless-sky"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Custom function to run after installation:
function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR"
    msg "$FgMagenta" "
Compiling $PROGDIR in '$(pwd)'

  MUST have Python >= 3.5
  MUST have scons  >= 3.1

"
    scons
}

## Notes shown before program is executed
PRERUN="
https://endless-sky.github.io/
"

find_and_run_executable "$@"
