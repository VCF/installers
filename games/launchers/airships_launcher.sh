#!/bin/bash

## Location of the executable:
PROGDIR="Airships"
LAUNCH="Airships";
## Location of the installer:
INSTDIR="Desura"
INSTNAME='airships-ea64-linux.zip'
## Installation post-processing:
INSTRENAME='airships-ea64-linux/Airships'
## Run comment:
PRERUN="Segmentation fault on Mint 18.3 Sylvia"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
