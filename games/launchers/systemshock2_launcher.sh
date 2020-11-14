#!/bin/bash

## Location of the executable:
PROGDIR="System Shock 2"
LAUNCH="SS2.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_system_shock_2_*.exe'

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
WINETARGET="GOG Games/$PROGDIR"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=27660

If keyboard does not work, run:
  $0 winecfg
... switch to Windows 8, and in Graphics tab check:
  'Allow the window manager to control the windows'
  https://askubuntu.com/a/700654
"

find_and_run_executable "$@"
