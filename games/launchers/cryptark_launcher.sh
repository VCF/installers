#!/bin/bash

## Location of the executable:
PROGDIR="Cryptark"
LAUNCH="Cryptark.bin.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='cryptark-*-bin-linux'
UNPACKDIR="$PROGDIR"
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTSAVEDIR="$HOME/.local/share/Cryptark"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

PREINST="

  When asked, specify install location as:  
    $GAMEDIR/$PROGDIR                       
"

find_and_run_executable "$@"
