#!/bin/bash

## Location of the executable:
PROGDIR="Dungeon Hack"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Dungeons and Dragons Classics"
INSTNAME='gog_dungeon_hack_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Specify any required APT packages:
APTPACKAGES='libpng12-0'

## Notes shown before program is executed
PRERUN="
  Requires libpng12 to function, which is no longer provided on modern
  (> 2018) Ubuntu platforms, at least not for AMD architecture

  https://askubuntu.com/q/895897

  https://www.linuxuprising.com/2018/05/fix-libpng12-0-missing-in-ubuntu-1804.html

"

find_and_run_executable "$@"
