#!/bin/bash
DfName="DwarfFortress"

## Location of the executable:
PROGDIR="$DfName"
LAUNCH="df"
## Location of the installer:
INSTDIR="Indie/$DfName"
INSTNAME='df_*_linux.tar.bz2'
## Installation post-processing:
INSTHELP="http://dwarffortresswiki.org/index.php/Installation#Linux"
INSTAPT="libsdl1.2debian libsdl-image1.2 libSDL-ttf2.0-0"
INSTRENAME="df_linux/$DfName"
INSTSAVEDIR="$HOME/Programs/$DfName/data/save"
PRERUN="
44.02 : Sometimes segfaults in Mint 18.3 Sylvia
"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable


exit


# https://github.com/splintermind/Dwarf-Therapist/tree/DF2014

set -e

PROGDIR="$HOME/Programs"
cd "$PROGDIR/df_linux"

set_title "Run Dwarf Fortress"

# gnome-terminal -t "Therapist" -e "dwarftherapist" &

msg 32 "Running Dwarf Fortress"
./dfhack 

#sleep 20

#msg 36 "Running Dwarf Therapist"

#exec dwarftherapist

msg 35 "Finished"
