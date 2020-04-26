#!/bin/bash

## Location of the executable:
PROGDIR="Darkest Dungeon"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='darkest_dungeon_2*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/Red Hook Studios/Darkest"

function addDLC {
    DLCFILE="$1"
    OLDINST="$INSTNAME"
    INSTNAME="$DLCFILE"
    installer=""
    findInstaller
    if [[ -z "$installer" ]]; then
        msg "$FgYellow" "  DLC absent: $INSTNAME"
    else
        msg "$FgBlue" "  Installing DLC:
    $installer
"
        installShell
    fi
    INSTNAME="$OLDINST"
}

## Custom function to run after installation:
function INSTFUNCTION {
    msg "$FgMagenta" "Installing DLCs"
    addDLC 'darkest_dungeon_musketeer_dlc_en_*.sh'
    addDLC 'darkest_dungeon_the_color_of_madness_*.sh'
}

find_and_run_executable "$@"
