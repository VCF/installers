#!/bin/bash

## Location of the executable:
PROGDIR="Cryptark"
LAUNCH="Crawl.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='cryptark-*-bin-linux'
## Installation post-processing:
INSTICON="$PROGDIR.png"
## INSTSAVEDIR="$HOME/.config/unity3d/Powerhoof/Crawl"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
