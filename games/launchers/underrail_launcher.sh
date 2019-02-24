#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Location of the executable:
PROGDIR="UnderRail"
LAUNCH="underrail.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_underrail_*.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
WINETARGET="GOG Games/UnderRail"
INSTTRICKS="allcodecs dotnet40"

## Installation post-processing:
INSTSAVEDIR="$HOME/Documents/My Games/Underrail"

INSTICON="$PROGDIR.jpg"
## Notes:
PRERUN="
WineHQ Bronze
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=33049

Required winetricks:
  allcodecs - For sound. Did not install properly first attempt
  dotnet40  - Make sure you install as Windows 98. 
              gacutil-net40.tar.bz2 is available in supportFiles/

Must turn off 'Autosave on Transitions'
Normal saves will claim to fail, but will actually work
"

find_and_run_executable "$@"
