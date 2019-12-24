#!/bin/bash

PROGDIR="Quest of Dungeons"
LAUNCH="QuestofDungeons"

## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='QuestofDungeons_linux_*.zip'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
