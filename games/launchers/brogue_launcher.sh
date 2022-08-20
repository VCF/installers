#!/bin/bash

## Location of the executable:
PROGDIR="Brogue"
LAUNCH="brogue"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='BrogueCE-*-linux-x86_64.tar.gz'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Rename the default install directory to something else:
INSTRENAME='BrogueCE-linux/'"$PROGDIR"


## Notes shown before program is executed
PRERUN="
  https://github.com/tmewett/BrogueCE
"

find_and_run_executable "$@"
