#!/bin/bash

## Location of the executable:
PROGDIR="Waterfox"
LAUNCH="waterfox"
## Location of the installer:
INSTDIR="OpenSource/Waterfox"
INSTNAME='waterfox-*.en-US.linux-x86_64.tar.bz2'
## Installation post-processing:
INSTRENAME='waterfox/'"$PROGDIR"
INSTICON="$PROGDIR.png"

PRERUN="Waterfox Firefox fork
  https://www.waterfoxproject.org/
  https://github.com/MrAlex94/Waterfox
"

my_dir="$(dirname "$0")"
xpiDir="$my_dir/PreWebExtensionsXPIs"
. "$my_dir/_launcher_functions.sh"

function INSTFUNCTION {

    profDir="$HOME/.waterfox"
    if [[ ! -d "$profDir" ]]; then
        msg "$FgYellow" "

Waterfox profile directory not yet created. After running Waterfox,
relaunch this script with:
  $0 custfunc
"
        return
    fi
    stndShort="stndProfile"
    stndProf="$profDir/$stndShort"
    if [[ ! -d "$stndProf" ]]; then
        defProf=$(find "$profDir" -name '*.default' | head -n1)
        if [[ -z "$defProf" ]]; then
            msg "$FgRed" "
I failed to find the default profile in:
  $profDir
"
            return
        fi
        defProf=$(basename "$defProf")
        msg "$FgCyan" "  Creating normalized symlink to profile
    $stndShort -> $defProf
"
        ln -s "$defProf" "$stndProf"
    fi

    ## Make sure the extensions directory is created
    mkdir -p "$stndProf/extensions"

    ## Copy over extensions
    targDir="$stndProf/extensions"
    msg "$FgBlue" "  Adding XPI extensions to profile:\n    '$targDir'"
    ## Oof. Reading from `find`: https://stackoverflow.com/a/23357277
    while IFS=  read -r -d $'\0'; do
        xpi=$(basename "$REPLY")
        td=$(mktemp -d)
        unzip -q "$xpiDir/$xpi" -d "$td"
        rdf="$td/install.rdf"
        if [[ ! -s "$rdf" ]]; then
            msg "$FgRed" "    Failed to find RDF manifest: $xpi"
            rm -rf "$td"
            continue
        fi
        xpid=""
        xpid=$(egrep -o '<(em:)?id>[^<]+<' "$rdf" | head -n1)
        if [[ -z "$xpid" ]]; then
            xpid=$(egrep -o 'NS1:id="[^"]+"' "$rdf" | head -n1)
            xpid=$(echo "$xpid" | sed 's/.*="//')
            xpid=$(echo "$xpid" | sed 's/"$//')            
        else
            xpid=$(echo "$xpid" | sed 's/.*>//')
            xpid=$(echo "$xpid" | sed 's/<$//')
        fi
        if [[ -z "$xpid" ]]; then
            msg "$FgRed" "    Failed to find ID in XPI: $xpi"
            echo "$rdf"
            continue
            rm -rf "$td"
            continue
        fi
        targXpi="$targDir/${xpid}.xpi"
        if [[ -s "$targXpi" ]]; then
            msg "$FgCyan"    "      Exists : $xpi"
        else
            msg "$FgMagenta" "  Installing : $xpi"
            cp "$xpiDir/$xpi" "$targXpi"
        fi
        rm -rf "$td"
    done < <(find "$xpiDir" -name '*.xpi' -print0)
}

find_and_run_executable "$@"
