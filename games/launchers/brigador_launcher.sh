#!/bin/bash

## Location of the executable:
PROGDIR="Brigador Up Armored Edition"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Brigador"
INSTNAME='brigador_up_armored_edition_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="Brigador.png"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
saveNote="
Saved data are in:
  $PROGDIR/game/
    profile.json
    settings.json
    bckup/
"

find_and_run_executable "$@"
