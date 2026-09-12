#!/bin/bash

## Location of the executable:
PROGDIR="VS Code"
LAUNCH="/usr/bin/code"

## Location of the installer on your file system:
INSTDIR="Visual Studio Code"
INSTNAME='code_*_amd64.deb'

## Installation post-processing:
INSTSAVEDIR="$HOME/.config/Code"
DORSYNC="true"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
