#!/bin/bash

## https://github.com/Aleph-One-Marathon/alephone/wiki/Linux-Install-Instructions#ubuntu
## Boost: https://stackoverflow.com/a/12578564
## Need libsdl2-image: https://github.com/Aleph-One-Marathon/alephone/issues/34

function INSTFUNCTION {
    targ="$GAMEDIR/$PROGDIR"
    games="$targ/share"
    if [[ ! -f "$targ/$LAUNCH" ]]; then
        ## Need to compile the source
        cd "$targ"


        msg "$FgRed" "
To properly install alephone (Marathon Trilogy), it needs these libraries:

  sudo apt-get install \\
    libboost-all-dev \\
    libsdl-dev \\
    libsdl-ttf2.0-dev \\
    libsdl2-image-dev \\
    libsdl-image1.2-dev \\
    libspeexdsp-dev \\
    libzzip-dev \\
    libavcodec-dev \\
    libavformat-dev \\
    libavutil-dev \\
    libswscale-dev \\
    libmad0-dev \\
    libsndfile1-dev \\
    libsmpeg-dev \\
    libcurl4-openssl-dev \\
    libsdl-net1.2-dev
"
        read -p "If you have not done so, Ctrl-C to exit. Otherwise, hit return ..."
        
        msg "$FgMagenta" "Configuring $LAUNCH ..."
        ./configure --prefix="$GAMEDIR/$PROGDIR"
        
        msg "$FgMagenta" "Making ..."
        make
        ## We don't want to install in /usr/local
        ##   alter source with sed: https://stackoverflow.com/a/5171935
        ##   sed with slashes: https://stackoverflow.com/a/16790859
        ##sed -i.bak "s:prefix = /usr/local:prefix = $GAMEDIR/$PROGDIR:g" Makefile
        ##sed -i.bak "s:/usr/local:$GAMEDIR/$PROGDIR:g" config.status
        msg "$FgMagenta" "Installing ..."
        make install
        msg "$FgMagenta" "Compiling finished ... hopefully?"
    fi
    [[ -d "$games" ]] || mkdir -p "$games"

    
    ## Need to install the data files
    gfs[1]="Marathon"
    gfs[2]="Marathon2"
    gfs[3]="MarathonInfinity"
    for gf in "${gfs[@]}"
    do
        INSTNAME="$gf-*-Data.zip"
        findInstaller
        if [[ -n "$installer" ]]; then
            msg "$FgMagenta" "
Extracting $gf data files
"
            unzip -q "$installer" -d "$games"
        fi
    done
}
