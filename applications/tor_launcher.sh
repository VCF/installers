#!/bin/bash

## Tor privacy-hardened web browser

## Location of the executable:
PROGDIR="Tor"
LAUNCH="Browser/start-tor-browser"

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

## Installation post-processing:
INSTRENAME='tor-browser_en-US/'$PROGDIR
INSTICON="tor.png"
NOTINTERM="Don't run in a terminal"

PRERUN="
https://www.torproject.org/projects/torbrowser.html.en
"

my_dir="$(dirname "$0")"
. "$my_dir/_standardize_firefox_profile.sh"
. "$my_dir/_launcher_functions.sh"

## Tor does NOT like having the profile directory relocated to another
## spot and then symlinked. So instead we will backup the profile
## folder "in place" using rsync:
profDir="$GAMEDIR/$PROGDIR/Browser/TorBrowser/Data/Browser"
RSYNCDIR="$profDir/profile.default"

## We need to do a few tweaks to the profile directory, mainly copying
## in XPI files and normalizing its location. We can't do that until
## Firefox runs at least once, so test for that in the body here:
standardizeProfile "$profDir" "$RSYNCDIR"

find_and_run_executable "$@"
