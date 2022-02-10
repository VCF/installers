#!/bin/bash

## Location of the executable:
PROGDIR="ToME 2"
LAUNCH="src/tome-x11"

## git repository path:
INSTGIT="git://github.com/tome2/tome2.git"

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='
cmake
build-essential
libboost-all-dev
libx11-dev
'

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.tome"

function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR"
    
    ## Compile
    if [[ -s "$LAUNCH" ]]; then
        msg "$FgCyan" "Main game engine has already been compiled"
    else
        msg "$FgMagenta;$BgYellow" "  ---- COMPILING $PROGDIR ----  "

        cmake .
        make
        
        if [[ -s "$LAUNCH" ]]; then
            msg "$FgGreen" "  Apparently succesful compilation"
        else
            msg "$FgRed;$BgYellow" "  Could not find launcher: $LAUNCH  "
        fi

    fi
}

#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

## Notes shown before program is executed
PRERUN="
Fork of the original 'Tales of Middle Earth' Rougelike
  https://github.com/tome2/tome2
  http://www.roguebasin.com/index.php/Tales_of_Middle_Earth

Keeps core dumping (X11) ...
"

find_and_run_executable "$@"
