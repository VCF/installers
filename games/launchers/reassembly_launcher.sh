#!/bin/bash

PROGDIR="Reassembly"
LAUNCH="linux/ReassemblyRelease64"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
