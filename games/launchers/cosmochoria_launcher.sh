#!/bin/bash

PROGDIR="Cosmochoria"
LAUNCH="cosmochoria"

# Need to do:
# sudo ln -sf /lib/x86_64-linux-gnu/libudev.so.1 /lib/x86_64-linux-gnu/libudev.so.0

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu:$HOME/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
