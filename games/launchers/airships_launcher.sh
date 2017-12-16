#!/bin/bash

PROGDIR="airships-ea64-linux"
LAUNCH="Airships";
INSTDIR="Desura"
INSTNAME='airships-ea64-linux.zip'

PRERUN="Segmentation fault on Mint 18.3 Sylvia"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
