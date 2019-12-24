#!/bin/bash

PROGDIR="Desktop Dungeons"
LAUNCH="DesktopDungeons.sh"

INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Desktop_Dungeons_EE_Linux_*.tar.gz'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
