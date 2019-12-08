#!/bin/bash

## Location of the executable:
PROGDIR="Guacamelee"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Guacamelee_linux_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
## INSTSAVEDIR="$HOME/.local/share/10tons/Crimsonland"

PRERUN="
========
Currently non-functional
Potentially corrupt installer
Possible bug with installer use of basename
========
"
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
