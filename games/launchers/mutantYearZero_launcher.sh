#!/bin/bash

## Location of the executable:
PROGDIR="Mutant Year Zero - Road to Eden"
LAUNCH="ZoneUE4.exe"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_mutant_year_zero_road_to_eden_myz_gog_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="64"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/WineMYZ"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="GOG Games/$PROGDIR"
## Any winetricks that might be needed:
INSTTRICKS="win7 d3dx9"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="Mutant Year Zero.png"

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
function INSTFUNCTION {
    echo "
Most recent version of winetricks required to install vcrun2019
  https://wiki.winehq.org/Winetricks#Getting_winetricks
  Prefix: $WINEPREFIX
"
    hereDir="${pwd}"
    cd "${HOME}/Downloads"

    if [[ ! -s "winetricks" ]]; then
        wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
        chmod +x winetricks
    fi
    ./winetricks vcrun2019 mf
    cd "$hereDir"
}

## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

## Notes shown before program is executed
PRERUN="
  https://lutris.net/games/install/16241/view
  https://software.kaminata.net/linux-wine-games/mutant-year-zero-road-to-eden-linux-dxvk-wine/

"

find_and_run_executable "$@"
