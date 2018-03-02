#!/bin/bash

### Shares installer with original Silent Storm

## Location of the executable:
PROGDIR="Cogmind"
LAUNCH="COGMIND.exe"
## Location of the installer:
INSTDIR="Indie/CogMind"
INSTNAME='COGMIND_*.zip'
## Installation post-processing:
INSTRENAME='COGMIND */'$PROGDIR
INSTSAVEDIR="$HOME/Programs/$PROGDIR/user"
INSTICON="$PROGDIR.png"
## Notes:


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
