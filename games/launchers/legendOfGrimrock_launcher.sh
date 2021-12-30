#!/bin/bash

## Location of the executable:
PROGDIR="LegendOfGrimrock"
LAUNCH="Grimrock.bin.x86_64"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="Grimrock"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/Legend of Grimrock"
INSTNAME='Grimrock-Linux-*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="Legend of Grimrock.png"

## Notes shown before the installer program runs
PREINST="
  Create the following folder:
    $GAMEDIR/$PROGDIR
  ... and choose for both options.

  An error is thrown at the end of installation but it seems ignorable.
"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/Almost Human/Legend of Grimrock"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

find_and_run_executable "$@"
