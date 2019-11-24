#!/bin/bash

## Location of the executable:
PROGDIR="GPXSee"
LAUNCH="foobar"
## Location of the installer:
INSTDIR="OpenSource/GPXSee"
INSTNAME='GPXSee-*.tar.gz'
## Installation post-processing:
INSTRENAME='waterfox/'"$PROGDIR"
INSTICON="$PROGDIR.png"

PRERUN="GPXSee 
  https://www.gpxsee.org/
  https://github.com/tumic0/GPXSee/
"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

function INSTFUNCTION {
    
}

find_and_run_executable "$@"
