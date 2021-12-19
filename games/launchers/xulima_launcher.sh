#!/bin/bash

## Location of the executable:
PROGDIR="Lords of Xulima"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_lords_of_xulima_2*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='
libgtk2.0-0:i386
'
## Environment values to set prior to launch
## Find the i386 library folder. Trying to be machine agnostic here:
##   https://askubuntu.com/a/115504
libDir="$(dpkg -L libgtk2.0-0:i386 |\
   grep 'libgtk2.0-0$' |\
   grep -v '/doc/' |\
   sed 's/libgtk2.0-0//')"
LAUNCHENV="LD_LIBRARY_PATH='$libDir'"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/My Games/Lords of Xulima"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Custom function to run after installation:
function INSTFUNCTION {
    addDLC 'gog_lords_of_xulima_deluxe_edition_dlc_*.sh'
}

find_and_run_executable "$@"
