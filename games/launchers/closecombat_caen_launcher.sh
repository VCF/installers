#!/bin/bash

#######################################################################

##  WINE 'GARBAGE' - Gateway to Caen

## I could not get CC Gateway to Caen to run under Wine 3.0. It
## installs without complaint, and launches a loading window, but then
## "goes nowhere" (stuck on window showing titular scene of infantry
## in front of half tracks).

#######################################################################

## Location of the executable:
PROGDIR="Close Combat Caen"
LAUNCH="autorun.exe"

## Location of the installer:
INSTDIR="GOG/Close Combat"
INSTNAME='setup_close_combat_gateway_to_caen_*.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/WineCC$wineBits"
WINEARCH="win$wineBits"
## Just flailing here. Looking for DLLs that have been required by
## other MatrixGames releases in Wine:
INSTTRICKS="d3dx9_43 wmp9 wmp10 dotnet20 dotnet30 gdiplus"
## Also ran GOG's 'Sword of the Stars - The Pit' installer, since I've
## learned that it's another 'native' way to get the .NET and XNA
## version 4 Frameworks installed. Didn't help.

## Installation post-processing:
## Capitalization may vary:
WINETARGET="GOG Games/Close Combat Gateway to Caen"
INSTSAVEDIR="drive_c/users/$USER/My Documents/My Games/Foobar"

INSTICON="$PROGDIR.jpg"
## Notes:
PRERUN="
WineHQ unranked
  Could not get it to run
  HKEY_CURRENT_USER\Software\Matrix Games\Close Combat Gateway to Caen
    Set PlayVideos to 00 00 00 00
    Also tried Windowed to 00 00 00 00
  Tried virtual desktop of 800x600

"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

## HKEY_CURRENT_USER\Software\Matrix Games\Close Combat Gateway to Caen
