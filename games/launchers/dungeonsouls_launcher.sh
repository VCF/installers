#!/bin/bash

## Location of the executable:
PROGDIR="Dungeon Souls"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='dungeon_souls_en_*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Installation post-processing:
INSTSAVEDIR="$HOME/.config/DungeonSouls"
INSTICON="$PROGDIR.png"

## Uses a deprecated (insecure) version of libcrypto that wasn't
## available from the Ubuntu repositories, but I found a copy in
## Steam's library folder:
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/"

find_and_run_executable "$@"

