#!/bin/bash

## http://wiki.naev.org/wiki/Main_Page
## https://github.com/naev/naev

## Location of the executable:
PROGDIR="Naev"
LAUNCH="naev"
## Location of the installer:
INSTGIT="git://github.com/naev/naev.git"
## Installation post-processing:
INSTRENAME='naev/Naev'
INSTSAVEDIR="$HOME/.local/share/naev"
APTPACKAGES="build-essential
automake
libsdl2-dev
libsdl2-image-dev
libgl1-mesa-dev
libxml2-dev
libfreetype6-dev
libpng12-dev
libopenal-dev
libvorbis-dev
binutils-dev
libzip-dev
libiberty-dev
autopoint
intltool
"
POSTRUN=""
INSTICON="$PROGDIR.png"

function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR"
    echo `pwd`
    exit
    ./autogen.sh && ./configure
    make
}


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
