#!/bin/bash

## Location of the executable:
PROGDIR="ADOM Ancient Domains Of Mystery English"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/ADOM"
INSTNAME='adom_ancient_domains_of_mystery_english_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="ADOM.png"

## Specify any required APT packages:
APTPACKAGES='
libluajit-5.1-2
libsdl2-ttf-2.0-0
'

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.adom.data"

find_and_run_executable "$@"
