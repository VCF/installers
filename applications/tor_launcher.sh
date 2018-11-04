#!/bin/bash

## Tor privacy-hardened web browser

## Location of the executable:
PROGDIR="Tor"
LAUNCH="start-tor-browser.desktop"
## Location of the installer:
if [[ -z "$(uname -m | grep x86_64)" ]]; then
    ## 32-bit
    INSTNAME='tor-browser-linux32-*_en-US.tar.xz'
    INSTDIR="Linux/Tor/32-bit"
else
    ## 65-bit
    INSTNAME='tor-browser-linux64-*_en-US.tar.xz'
    INSTDIR="Linux/Tor"
fi
## No save files involved:
INSTSAVEDIR='NONE'
## Installation post-processing:
INSTRENAME='tor-browser_en-US/'$PROGDIR
INSTICON="tor.png"
NOTINTERM="Don't run in a terminal"

PRERUN="
https://www.torproject.org/projects/torbrowser.html.en

"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
