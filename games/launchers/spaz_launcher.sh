#!/bin/bash

## Location of the executable:
PROGDIR="spaz"
LAUNCH="SPAZ"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/Space Pirates and Zombies/"
INSTNAME='spaz-linux-humblebundle-*-bin'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="SPAZ.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/SpacePiratesAndZombies"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

find_and_run_executable "$@"
