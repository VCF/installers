#!/bin/bash

## Location of the executable:
PROGDIR="Enclave"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_enclave_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

msg "$FgRed" "

Linux version of the game is actually a wrapper around Wine
Did not work - no installation attempted

"

exit

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"

## Notes shown before program is executed
PRERUN="
Turns out the 'linux version' is just a wrapper around wine
... and it does not work. Will work to refactor this to use Wine directly

There's a Lutris script that is distressingly complex:
  https://lutris.net/games/install/16597/view
"

find_and_run_executable "$@"
