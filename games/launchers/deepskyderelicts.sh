#!/bin/bash

## Location of the executable:
PROGDIR="Deep Sky Derelicts"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='deep_sky_derelicts_1*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.config/unity3d/Snowhound/Deep Sky Derelicts"
INSTICON="$PROGDIR.jpg"
## Notes:

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Custom function to run after installation:
function INSTFUNCTION {
    ## Also install DLC
    OLDINST="$INSTNAME"
    INSTNAME='deep_sky_derelicts_new_prospects_*.sh'
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

find_and_run_executable "$@"
