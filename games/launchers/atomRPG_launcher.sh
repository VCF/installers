#!/bin/bash

## Location of the executable:
PROGDIR="ATOM RPG"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='atom_rpg_post_apocalyptic_indie_game_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
INSTRENAME="ATOM RPG Post apocalyptic indie game/$PROGDIR"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/AtomTeam/Atom"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"

find_and_run_executable "$@"
