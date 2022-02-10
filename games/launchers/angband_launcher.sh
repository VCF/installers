#!/bin/bash

## Location of the executable:
PROGDIR="Angband"
LAUNCH="src/angband"
## Arguments to pass to the executable when running:
## suboption -n8 will open 8 sub-windows
LAUNCHARGS="-mx11 -- -n8"

## git repository path:
INSTGIT="git://github.com/angband/angband.git"

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/lib/save"


## Custom function to run after installation:
function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR"
    
    ## Compile
    if [[ -s "$LAUNCH" ]]; then
        msg "$FgCyan" "Main game engine has already been compiled"
    else
        msg "$FgMagenta;$BgYellow" "  ---- COMPILING $PROGDIR ----  "

        ./autogen.sh
        ./configure --with-no-install
        make
        
        if [[ -s "$LAUNCH" ]]; then
            msg "$FgGreen" "  Apparently succesful compilation"
        else
            msg "$FgRed;$BgYellow" "  Could not find launcher: $LAUNCH  "
        fi

    fi
}

## Notes shown before program is executed
PRERUN="
Angband Rouge-Like
  https://rephial.org/
  https://github.com/angband/angband/
  http://www.roguebasin.com/index.php/Angband

Saves do not backup the configuration folder found at:
  '$HOME/.angband/'
"

find_and_run_executable "$@"
