#!/bin/bash

## Normalizes modern (2020) Firefox profile folders that use
## WebExtenstion XPIs

function standardizeProfile {
    ## eg $HOME/.mozilla/firefox
    ## Parameterized so it can be used with Tor, too
    profDir="$1"
    xpiDir="$my_dir/WebExtensionXPIs"
    stndShort="stndProfile"
    stndProf="$profDir/$stndShort"

    if [[ ! -d "$profDir" ]]; then
        msg "$FgYellow" "

Firefox profile directory not yet created. After running Firefox,
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
        defProf="$(find "$profDir" -name '*.default' -or -name '*.Default User' | head -n1)"
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

    prefFile="$stndProf/user.js"
    if [[ ! -f "$prefFile" ]]; then
        defPref="$my_dir/firefox_user.js"
        if [[ -f "$defPref" ]]; then
            cp "$defPref" "$prefFile"
            msg "$FgCyan" "  Pref file created: $prefFile"
        else
            msg "$FgRed" "
Your user pref file does not exist:
  $prefFile
... but I could not find the default at:
  $defPref
"
         fi
    fi
    
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
        rdf="$td/manifest.json"
        if [[ ! -s "$rdf" ]]; then
            msg "$FgRed" "    Failed to find manifest.json: $xpi"
            rm -rf "$td"
            continue
        fi
        xpid=""
        xpid="$(egrep -o '"id": {0,}".*"' "$rdf" | head -n1)"
        if [[ -z "$xpid" ]]; then
            xpid=$(egrep -o 'NS1:id="[^"]+"' "$rdf" | head -n1)
            xpid=$(echo "$xpid" | sed 's/.*="//')
            xpid=$(echo "$xpid" | sed 's/"$//')            
        else
            xpid="$(echo "$xpid" | sed 's/"id": *"//')"
            xpid="$(echo "$xpid" | sed 's/"$//')"
        fi
        if [[ -z "$xpid" ]]; then
            msg "$FgRed" "    Failed to find ID in XPI: $xpi"
            msg "$FgBlue$BgYellow" "    Tempdir: $td"
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
    desktopIcon
}
