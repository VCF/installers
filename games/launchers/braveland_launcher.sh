#!/bin/bash

### Shares installer with original Silent Storm

## Location of the executable:
PROGDIR="Braveland"
LAUNCH="Braveland.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/Braveland"
INSTNAME='braveland-linux-*.tar'
## Installation post-processing:
#INSTSAVEDIR="$HOME/Programs/$PROGDIR/user"
INSTICON="$PROGDIR.png"
## Notes:


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
