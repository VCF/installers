#!/bin/bash

## Location of the executable:
PROGDIR="Depths of Peril"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_depths_of_peril_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
## APTPACKAGES='i965-va-driver:i386'

## Notes shown before the installer program runs

echo "
DOES NOT WORK
  (at least on integrated graphics)

Appears to need specific 32-bit driver libraries, but Mesa is unhappy with them

libGL error: MESA-LOADER: failed to open i965 (search paths /usr/lib/i386-linux-gnu/dri:\$${ORIGIN}/dri:/usr/lib/dri)
libGL error: failed to load driver: i965
libGL error: MESA-LOADER: failed to open swrast (search paths /usr/lib/i386-linux-gnu/dri:\$${ORIGIN}/dri:/usr/lib/dri)
libGL error: failed to load driver: swrast

Installing 'i965-va-driver:i386' did not help

"

exit

## Notes shown before program is executed
#PRERUN="
#  Any message you want the program to display before running
#"

find_and_run_executable "$@"
