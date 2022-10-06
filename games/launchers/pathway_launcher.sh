#!/bin/bash

## Location of the executable:
PROGDIR="Pathway"
LAUNCH="start.sh"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='pathway_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
##    https://www.gog.com/forum/pathway/linux_version/post9
APTPACKAGES='libsdl2-2.0-0'
## Normally a new terminal is opened to launch. Flag to prevent this:
## NOTINTERM="No launching terminal"

## Notes shown before the installer program runs
#PREINST="
#  Any message you want the installer to display before running, eg
#  Be sure to uncheck the box 'send details to NSA'
#"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Custom function to run after installation:
#function INSTFUNCTION {
#  echo "For example, properly setting executable bits"
#  addDLC 'foobar_pro_DLC_pack_*.sh'
#}
## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

## Notes shown before program is executed
PRERUN="
  Not running on fanless system. May be issue with integrated Intel graphics?
"

find_and_run_executable "$@"
