#!/bin/bash

## Location of the executable:
PROGDIR="Naev"
LAUNCH="naev.sh"
## Location of the installer:
INSTGIT="git://github.com/naev/naev.git"

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Specify any required APT packages:
APTPACKAGES="
libsdl2-2.0-0
libsdl2-image-2.0-0
libgl1-mesa-dri
libxml2
libfreetype6
libpng-dev
libopenal1
libvorbis0a
libzip2
libphysfs1
libwebp6
libcholmod3
libcxsparse3
libopenblas-base

install
build-essential
git
meson
libsdl2-dev
libsdl2-image-dev
libgl1-mesa-dev
libxml2-dev
libfreetype6-dev
libpng-dev
libopenal-dev
libvorbis-dev
binutils-dev
libwebp-dev
libiberty-dev
intltool
python3-yaml
libfontconfig1-dev
libphysfs-dev
libopenblas-dev
libsuitesparse-dev
"
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/naev"


function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR"
    msg "$FgMagenta" "
Compiling $PROGDIR
  Working directory: '$(pwd)'

  Updating git submodules:
"
    git submodule init
    git submodule update
    
    msg "$FgMagenta" "
Compiling ...
"
    meson setup build .
    cd build
    meson compile
}

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Notes shown before program is executed
PRERUN="
  http://wiki.naev.org/wiki/Main_Page
  https://github.com/naev/naev

  Meson is NOT working on Mint 19.3
  Idiotic complaint about unmatched parens that are clearly matched.
"

find_and_run_executable "$@"
