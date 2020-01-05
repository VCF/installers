#!/bin/bash

## Location of the executable:
PROGDIR="Antichamber"
LAUNCH="Antichamber.sh"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='antichamber_*linux*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.local/share/AlexanderBruce/Antichamber/SavedGame.bin"

find_and_run_executable "$@"
