#!/bin/bash

## Location of the executable:
PROGDIR="Everspace 2"
LAUNCH="Everspace2.exe"
## Arguments to pass to the executable when running:
LAUNCHARGS="-dx11"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_everspacetm_2_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="64"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/WineEverspace2"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="GOG Games/EVERSPACE™ 2"
## Any winetricks that might be needed:
## INSTTRICKS="vcrun2019" ## See INSTFUNCTION below
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Normally a new terminal is opened to launch. Flag to prevent this:
## NOTINTERM="No launching terminal"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Local Settings/Application Data/ES2/Saved/SaveGames"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "
Most recent version of winetricks required to install vcrun2019
  https://wiki.winehq.org/Winetricks#Getting_winetricks
"
    hereDir="${pwd}"
    cd "${HOME}/Downloads"

    if [[ ! -s "winetricks" ]]; then
        wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
        chmod +x winetricks
    fi
    ./winetricks vcrun2019 mf

    
    echo "
Need most recent version of Visual C++ from Microsoft:
  https://steamcommunity.com/app/1128920/discussions/6/3123786356699100510/#c3123786356705360102
"
    redistDir="$GAMEDIR/$PROGDIR/Engine/Extras/Redist/en-us"
    vcfile="UE4PrereqSetup_x64.exe"
    path="$redistDir/$vcfile"
    oldPath="${path}-OLD"
    if [[ ! -s "$oldPath" ]]; then
        echo "Original vc_redist moved: $oldPath"
        mv "$path" "$oldPath"
        
        wget https://aka.ms/vs/16/release/vc_redist.x64.exe
        mv "vc_redist.x64.exe" "$path"
    else
        echo "Newest vc_redist already installed"
    fi
    
    cd "$hereDir"
}

## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

## Notes shown before program is executed
PRERUN="
Proton Gold:
  https://www.protondb.com/app/1128920
"

find_and_run_executable "$@"
