#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Location of the executable:
PROGDIR="System Shock"
LAUNCH="sshock.exe"

## Location of the installer:
INSTDIR="GOG/System Shock"
INSTNAME='setup_system_shock_enhanced_edition_*.exe'

## Wine configuration:
wineBits="32"
export WINEPREFIX="$HOME/Wine$wineBits"
export WINEARCH="win$wineBits"

## INSTTRICKS="corefonts vcrun2013"
## WineHQ says is needed for music:
APTPACKAGES="fluidsynth
fluid-soundfont-gm"

## Installation post-processing:
## Capitalization may vary:
WINETARGET="GOG Games/System Shock Enhanced Edition"
## WINEARGS="/nogui" # Get extra screen realestate
INSTSAVEDIR="drive_c/users/$USER/Application Data/Nightdive Studios/System Shock EE"

INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=33978

"

function RUNFUNCTION {
    ## Per WineHQ notes to get music to work:
    ## fluidsynth --audio-driver=alsa /usr/share/sounds/sf2/FluidR3_GM.sf2
    
    ## Couldn't get that to work. Can confirm no music. Leaving this
    ## here as a placeholder, but apparently bash does not like an
    ## empty function so putting in a more-or-less null-op:
    pwd
}

find_and_run_executable "$@"
