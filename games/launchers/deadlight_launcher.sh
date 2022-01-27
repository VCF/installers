#!/bin/bash

## Location of the executable:
PROGDIR="Deadlight"
LAUNCH="Binaries/Win64/LOTDGame.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_deadlight_directors_cut_*.exe'

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
WINETARGET="GOG Games/Deadlight - Director's Cut"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/My Games/UnrealEngine3/LOTDGame"

## Notes shown before program is executed
PRERUN="
Wine (Steam) - Mix of Garbage / Platinum
  https://appdb.winehq.org/appview.php?iAppId=14627
  Worked fine for me ...
"

find_and_run_executable "$@"
