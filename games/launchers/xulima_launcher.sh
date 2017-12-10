#!/bin/bash

PROGDIR="Lords of Xulima"
LAUNCH="start.sh"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
