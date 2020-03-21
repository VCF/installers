#!/bin/bash

## Location of the executable:
PROGDIR="Doom the RougeLike"
LAUNCH="doomrl"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='doomrl-linux-x64-0997.tar.gz'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Rename the default install directory to something else:
INSTRENAME='doomrl-linux-*/'$PROGDIR

## Specify any required APT packages:
APTPACKAGES='libsdl-mixer1.2'

## Notes shown before program is executed
PRERUN="
  https://drl.chaosforge.org/
"

find_and_run_executable "$@"
