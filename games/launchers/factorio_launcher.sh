#!/bin/bash

PROGDIR="Factorio"
LAUNCH="start.sh"
INSTDIR="GOG/Factorio"
INSTNAME='factorio_en_*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
