#!/bin/bash

## Location of the executable:
PROGDIR="Name of Directory After Installation"
LAUNCH="whatActuallyRunsTheProgram.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='installer_file_name_*.zip'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Parameters for archives (zip/gz):
## Define a parent directory for unpacking archives:
## UNPACKDIR="$PROGDIR"
## Rename the default install directory to something else:
## INSTRENAME='NameAfterUnpacking/'$PROGDIR

## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'

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

find_and_run_executable "$@"
