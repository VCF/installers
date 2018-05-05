#!/bin/bash

### Shares installer with Sentinels sequel

## Location of the executable:
PROGDIR="LegoHarryPotter1-4"
#PROGSUBDIR="Silent Storm"
LAUNCH="LEGOHarryPotter.exe"

## Location of the installer:
INSTDIR="GOG/Lego Harry Potter"
INSTNAME='setup_lego_harry_potter_1-4_*.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
INSTTRICKS="xna40"

## Installation post-processing:
## Capitalization may vary:
WINETARGET="GOG Games/LEGO Harry Potter 1-4"
INSTSAVEDIR="drive_c/users/$USER/Application Data/WB Games/LEGO® Harry Potter™/SavedGames"

INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=11718

  Requires xna40 (.NET Framework)
    Could not get xna40 to install with winetricks on wine-3.0 !
      With neither Mint 18.3 nor Ubuntu 16.04
    Used another game installer (SotS The Pit) to leverage it's .NET installer

  Likely requires a 32-bit Wine prefix, if for no other reason to install .NET
"

function INSTFUNCTION {
    ## https://appdb.winehq.org/objectManager.php?sClass=version&iId=20680
    wineDriveC
    confFile="$cDrive/users/$USER/Application Data/WB Games/LEGO® Harry Potter™/pcconfig.txt"
    if [[ ! -s "$confFile" ]]; then
        msg "$FgRed" "Configuration file is not yet available.
Run the game at least once, then run:
  $0 custfunc
... to change DesiredDynamicLightQuality to a safe value.
"
        return
    fi
    
    ## https://stackoverflow.com/a/11245501 # Tell sed to change the line
    sed -i '/DesiredDynamicLightQuality  2/c\DesiredDynamicLightQuality  0' "$confFile"
    msg "$FgMagenta" "
Updated dynamic light quality to avoid WineHQ-reported issues:
  $(grep DesiredDynamicLightQuality "$confFile")
"
}


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
