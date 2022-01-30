#!/bin/bash

## Location of the executable:
PROGDIR="Avernum 1"
LAUNCH="Avernum.exe"

## Location of the installer on your file system:
INSTDIR="GOG/Avernum"
INSTNAME='setup_avernum_escape_from_the_pit_1.0.1_(20652).exe'

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
WINETARGET="GOG Games/Avernum - Escape From The Pit"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/Spiderweb Software/Avernum Saved Games"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Notes shown before program is executed
PRERUN="
Wine Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=28618

  This is the 2011 'reboot' of the first episode published in 1995
  https://en.wikipedia.org/wiki/Avernum:_Escape_from_the_Pit

  The GOG package with this also includes the original installer, which will
  be something like setup_avernum_2.1.0.4.exe
"

find_and_run_executable "$@"
