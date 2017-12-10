#!/bin/bash

PROGDIR="Torchlight2"
LAUNCH="Torchlight2.bin.x86_64"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
