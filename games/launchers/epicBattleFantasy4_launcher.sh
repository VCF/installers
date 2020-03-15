#!/bin/bash

echo "

Fails to install. Tried 32- and 64-bit, plus dotnet462

"

exit

## Location of the executable:
PROGDIR="Epic Battle Fantasy 4"
LAUNCH="whatActuallyRunsTheProgram.exe"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='EpicBattleFantansy4.exe'

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
WINETARGET="Program Files/Foo Bar"
## Any winetricks that might be needed:
INSTTRICKS="dotnet462"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

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

## Custom function to run after installation:
#function INSTFUNCTION {
#  echo "For example, properly setting executable bits"
#}
## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

## Notes shown before program is executed
PRERUN="

Not too helpful:
  https://www.protondb.com/app/265610

"

find_and_run_executable "$@"
