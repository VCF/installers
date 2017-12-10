#!/bin/bash

PROGDIR="Delver"
LAUNCH="run-delver.sh"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
