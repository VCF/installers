#!/bin/bash

## Location of the executable:
PROGDIR="Darkest Dungeon"
LAUNCH="start.sh"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='darkest_dungeon_2*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Normally a new terminal is opened to launch. Flag to prevent this:
## NOTINTERM="No launching terminal"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

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
    echo "Installing DLCs"
    addDLC 'darkest_dungeon_musketeer_dlc_en_*.sh'
    addDLC 'darkest_dungeon_the_color_of_madness_*.sh'
}

## Notes shown before program is executed
#PRERUN="
#  Any message you want the installer to display before running
#"

find_and_run_executable "$@"
