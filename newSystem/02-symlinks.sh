#!/bin/bash

## Set some symlinks for commonly-used applications in home directory

TARGETS="
/abyss/Media/scripts/check_movies.sh
/abyss/Linux/scripts/findGames.sh
/abyss/Common/ToFile/MailTopics.txt
$HOME/Helpers/utils/resetPlasmaShell.sh
$HOME/confFiles/systemSetup/sshSetup.sh
$HOME/RandomWordList/randomWordList.pl
/abyss/Common/ToFile
"

## Split string on newlines: https://stackoverflow.com/a/19772067
IFS=$'\n' read -rd '' -a SPLITLINES <<< "$TARGETS"

for path in "${SPLITLINES[@]}"
do
    bn="$(basename "$path")"
    if [[ "$bn" == "sshSetup.sh" ]]; then
        ## Shorter alias
        bn="ssh.sh"
    fi
    trg="$HOME/$bn"

    if [[ -L "$trg" ]]; then
        echo "Already linked:
    $trg
"
    else
        echo "Linking:
    $path
... to:
    $trg
"
        ln -s "$path" "$trg"
    fi
done
