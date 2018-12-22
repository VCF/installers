#!/bin/bash

## Tor privacy-hardened web browser

## Location of the executable:
PROGDIR="Cytoscape"
LAUNCH="Cytoscape"
## Location of the installer:
INSTNAME='Cytoscape_*_unix.sh'
INSTDIR="Linux/Cytoscape"
## No save files involved:
INSTSAVEDIR='NONE'
## Installation post-processing:
INSTICON="$PROGDIR.png"

PRERUN="
https://cytoscape.org/
    Proxy: Edit > Preferences > Proxy Settings ...
"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
