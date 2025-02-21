#!/bin/bash

## Location of the executable:
PROGDIR="TiddlyDesktop"
LAUNCH="nw"
## Location of the installer:
INSTDIR="OpenSource/TiddlyWiki"
INSTNAME='tiddlydesktop-linux64-v*.zip'
## Installation post-processing:
INSTRENAME='TiddlyDesktop-linux64-*/'"$PROGDIR"
INSTICON="TiddlyWikiHex.png"
## Normally a new terminal is opened to launch. Flag to prevent this:
NOTINTERM="YES"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/TiddlyDesktop"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

PRERUN="TiddlyWiki stand-alone application
  https://github.com/TiddlyWiki/TiddlyDesktop
  https://tiddlywiki.com/
"

find_and_run_executable "$@"
