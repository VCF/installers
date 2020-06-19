#!/bin/bash

## Needed to use the "portable" installation

## Location of the executable:
PROGDIR="MyPhoneExplorer"
LAUNCH="MyPhoneExplorer portable.exe"

## Location of the installer on your file system:
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='MyPhoneExplorer_Setup_v*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="32"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="Program Files/$PROGDIR"   # Not the 'portable' version
WINETARGET="users/$USER/Desktop/$PROGDIR portable"
## Any winetricks that might be needed:
##   Needs Visual Basic MSVBVM60.DLL
INSTTRICKS="vb6run"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
##   Android Debug Bridge
APTPACKAGES='adb'
## Normally a new terminal is opened to launch. Flag to prevent this:
## NOTINTERM="No launching terminal"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Data"

INSTHELP="
When given the option, please select the 'portable' option during
installation.
"

## Notes shown before program is executed
PRERUN="
WineHQ Gold:
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=31007
"

find_and_run_executable "$@"
