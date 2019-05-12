#!/bin/bash

## Location of the executable:
PROGDIR="King Arthurs Gold"
LAUNCH="rungame.sh"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='kagbeta-linux32-client.tar.gz'
## Installation post-processing:
## TODO - Not sure where save files are ...
## INSTSAVEDIR=""
INSTRENAME='kagbeta-linux32-client/'$PROGDIR
INSTICON="$PROGDIR.png"
## Notes:

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Make the launcher executable
## Due to updates, this should be run each time ...
chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"


find_and_run_executable "$@"
