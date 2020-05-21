#!/bin/bash

PROGDIR="Torchlight2"
LAUNCH="Torchlight2.bin.x86_64"

## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Torchlight2-linux-*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/Runic Games/Torchlight 2"

find_and_run_executable "$@"
