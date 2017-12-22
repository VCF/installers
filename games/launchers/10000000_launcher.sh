#!/bin/bash

## Location of the executable:
PROGDIR="10000000"
LAUNCH="10000000.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='10000000_Linux.tar.gz'
## Installation post-processing:
INSTRENAME='Linux/'"$PROGDIR"
INSTSAVEDIR="$HOME/.config/unity3d/EightyEightGames/10000000"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
