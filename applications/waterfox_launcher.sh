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
NOTINTERM="YES"

DORSYNC="YES" # Backup profile directory by rsync, not tar.gz

my_dir="$(dirname "$0")"
xpiDir="$my_dir/PreWebExtensionsXPIs"
. "$my_dir/_launcher_functions.sh"

## We need to do a few tweaks to the profile directory, mainly copying
## in XPI files and normalizing its location. We can't do that until
## Waterfox runs at least once, so test for that in the body here:
function standardizeProfile {
    profDir="$HOME/.waterfox"
    stndShort="stndProfile"
    stndProf="$profDir/$stndShort"
    if [[ ! -d "$profDir" ]]; then
        msg "$FgYellow" "

Waterfox profile directory not yet created. After running Waterfox,
relaunch this script with:
  $0 custfunc
"
        return
    fi
    
    if [[ -d "$stndProf" ]]; then
        ## We have already made a normalized symlink
        ## In order to define INSTSAVEDIR we still need its target
        defProf="$profDir/$(readlink "$stndProf")"
    else
        ## Normalize the profile directory to a standard name
        ## This normalized link is sought by some other functions
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
    ## We will also set the "save diretory" to the profile
    INSTSAVEDIR="$defProf"
    saveLocation
    
    ## Make sure the extensions directory is created
    mkdir -p "$stndProf/extensions"

    ## Copy over extensions
    targDir="$stndProf/extensions"
    copyDone="$targDir/vcfDoneXpiCopy"
    [[ -s "$copyDone" ]] && return
    
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
    date > "$copyDone"
}
standardizeProfile

PRERUN="Waterfox Firefox fork
  https://www.waterfoxproject.org/
  https://github.com/MrAlex94/Waterfox
"


find_and_run_executable "$@"
