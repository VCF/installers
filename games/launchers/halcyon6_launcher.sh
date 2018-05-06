#!/bin/bash

## Location of the executable:
PROGDIR="Halcyon6"
LAUNCH="H6.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/Halcyon 6"
INSTNAME='H6LINUX.zip'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTRENAME="H6LINUXGoG/$PROGDIR"
INSTSAVEDIR="$HOME/.config/unity3d/MASSDMG/Halcyon6LSE"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
