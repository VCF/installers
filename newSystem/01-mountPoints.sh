#!/bin/bash

## NFS mountpoints

echo "

If this system is 'privileged' (has access to full NFS server) you
should REMOVE two subdirectories, as these will be brought in by the
core /abyss mount:

  rmdir /abyss/Media
  rmdir /abyss/Installers

"

sudo mkdir -p \
     /abyss/Media \
     /abyss/Installers \
     /abyss/Common

sudo chmod 0777 \
     /abyss/Media \
     /abyss/Installers \
     /abyss/Common

