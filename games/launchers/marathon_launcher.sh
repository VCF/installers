#!/bin/bash

## Location of the executable:
PROGDIR="Marathon"
EPISODE="Marathon"
LAUNCH="bin/alephone"
LAUNCHARGS="share/$EPISODE"
## Location of the installer:
INSTDIR="OpenSource/Marathon"
INSTNAME='AlephOne-*.tar.bz2'
## Installation post-processing:
INSTRENAME='AlephOne-*/'"$PROGDIR"
INSTICON="$EPISODE.png"
INSTSAVEDIR="$HOME/.alephone"

PRERUN="Marathon is open-sourced as AlephOne:
  https://alephone.lhowon.org/
"

my_dir="$(dirname "$0")"
. "$my_dir/compile_marathon.sh"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
