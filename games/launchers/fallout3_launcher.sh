#!/bin/bash

### Eh. Not working on low-end system with built-in graphics

## Location of the executable:
PROGDIR="Fallout 3"
LAUNCH="Fallout3.exe"
LAUNCHINIT="FalloutLauncher.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_fallout_3_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Wine configuration:
wineBits="64"
## Getting messy enough that I want it in it's own prefix:
WINEPREFIX="$HOME/WineFallout3_$wineBits"
WINEARCH="win$wineBits"
APTPACKAGES="winetricks"
## https://appdb.winehq.org/objectManager.php?sClass=version&iId=14322
# INSTTRICKS="d3dx9 cc580 comctl32 directx9 dxdiagn l3codecx msasn1 msxml3 quartz vcrun2005 vcrun2008 vcrun2010 devenum vcrun2005sp1" 
INSTTRICKS="d3dx9 cc580 vcrun2005 directx9 l3codecx quartz"
## Installation post-processing:
WINETARGET="GOG Games/Fallout 3"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/My Games/Fallout3"
DORSYNC="yes"
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Notes shown before program is executed
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=37374

  Works fine on high-spec computer.

  Significant problems on low-spec computer - crashes during loading screen
  on start of new game. Integrated video issues? Drivers?
"

find_and_run_executable "$@"

