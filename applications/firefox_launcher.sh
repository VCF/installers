#!/bin/bash

## Location of the executable:
PROGDIR="Firefox"
LAUNCH="firefox"
## Location of the installer:
INSTREPO="firefox"
## Installation post-processing:
INSTICON="$PROGDIR.png"

NOTINTERM="YES" # Don't open a terminal to launch
DORSYNC="YES"   # Backup profile directory by rsync, not tar.gz

my_dir="$(dirname "$0")"
. "$my_dir/_standardize_firefox_profile.sh"
. "$my_dir/_launcher_functions.sh"

## We need to do a few tweaks to the profile directory, mainly copying
## in XPI files and normalizing its location. We can't do that until
## Firefox runs at least once, so test for that in the body here:
standardizeProfile "$HOME/.mozilla/firefox"

find_and_run_executable "$@"
