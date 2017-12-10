#!/bin/bash

PROGDIR="Barony"
LAUNCH="barony.x86_64"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
