#!/bin/bash

## Location of the executable:
PROGDIR="FreeCAD"
LAUNCH="$PROGDIR.AppImage"

## Location of the installer on your file system:
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='FreeCAD_*-x86_64.AppImage'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.FreeCAD"

find_and_run_executable "$@"
