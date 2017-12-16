#!/bin/bash

## Location of the executable:
PROGDIR="10000000"
LAUNCH="10000000.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/10000000"
INSTNAME='10000000_Linux.tar.gz'
## Installation post-processing:
INSTRENAME='Linux/10000000'
INSTSAVEDIR="$HOME/.config/unity3d/EightyEightGames/10000000"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
