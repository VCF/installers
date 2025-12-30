#!/bin/bash

## Location of the executable:
PROGDIR="Google Chrome"
LAUNCH="google-chrome"
## If the program ultimate runs as a different executable, list here:
## LAUNCHCHK="google-chrome"

## Location of the installer on your file system:
INSTDIR="Other/$PROGDIR"
INSTNAME='google-chrome-stable_current_amd64.deb'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

NOTINTERM="YES" # Don't open a terminal to launch
# DORSYNC="YES"   # Backup profile directory by rsync, not tar.gz

find_and_run_executable "$@"
