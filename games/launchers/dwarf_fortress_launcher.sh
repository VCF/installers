#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

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
