#!/bin/bash

## This script will 'refresh' all submodules in the repository that
## the script resides in:
##        --init : Initialize if not done so already
##      --remote : Will update to point to most recent commit of the branch
##   --recursive : I hear you like submodules, so I put submodules in
##                 your submodules

## Because I keep having to look here:
##    https://github.com/VCF/generalUtilities/blob/master/SubModuleNotes.md
## ... to remember how to do this

## script folder: https://stackoverflow.com/a/246128
my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


git -C "$my_dir" \
    submodule update --init --recursive --remote
