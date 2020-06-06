#!/bin/bash

## Location of the executable:
PROGDIR="Arx Fatalis"
LAUNCH="ARX.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_arx_fatalis.exe'

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
WINETARGET="Program Files/GOG.com/Arx Fatalis"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Save"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Custom function to run after installation:
function INSTFUNCTION {
    ## Magic not usable unless the control key is set to invoke it:
    PDIR="$GAMEDIR/$PROGDIR"
    cat "$PDIR/cfg_default.ini" | \
        sed 's/magic_mode_k0=---/magic_mode_k0=LControl/' > \
            "$PDIR/cfg.ini"
}

## Notes shown before program is executed
PRERUN="
Please configure winecfg to turn off window manager control:
  WINEARCH=win32 WINEPREFIX=$HOME/Wine32 winecfg 
"

find_and_run_executable "$@"
