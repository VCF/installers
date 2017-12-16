#!/bin/bash

## Location of the executable:
PROGDIR="Cosmochoria/linux64"
LAUNCH="cosmochoria"
## Location of the installer:
INSTDIR="Humble Indie Bundle/Cosmochoria"
INSTNAME='Cosmochoria_*_Linux.zip'
## Installation post-processing:
INSTRENAME='Cosmochoria*/Cosmochoria'
INSTSAVEDIR="$HOME/.config/Cosmochoria"
PRERUN="If run fails, check LogFile.txt for 'libudev.so.0' error. Solve with:
  sudo ln -s /lib/x86_64-linux-gnu/libudev.so.1 /lib/x86_64-linux-gnu/libudev.so.0
"

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu:$HOME/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
