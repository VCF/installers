#!/bin/bash

PROGDIR="10000000"
LAUNCH="10000000.x86_64"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
