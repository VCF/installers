#!/bin/bash

## Location of the executable:
PROGDIR="Stellar Tactics"
LAUNCH="StellarTactics.exe"
## Arguments to pass to the executable when running:
LAUNCHARGS="Abyss.stk"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_stellar_tactics_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="64"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="GOG Games/StellarTactics"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Save"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "Patching to most recent version ..."
    addDLC 'patch_stellar_tactics_0.596_(52097)_to_0.599_(52365).exe'
}

## Notes shown before program is executed
PRERUN="
Proton Platinum:
  https://www.protondb.com/app/465490
"

find_and_run_executable "$@"
