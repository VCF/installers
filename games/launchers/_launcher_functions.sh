#!/bin/bash

GAMEDIR="$HOME/Programs"
SAVEDIR="$HOME/Documents/GameFiles"
LOGFILE="LaunchLog.txt"
INSTROOT="/abyss/Installers"

## Library of functions used to install and launch games. Installed
## games are expected to be in $GAMEDIR (above). Launching will look
## for two environment variables:

##    $PROGDIR - The first-level subdirectory of $GAMEDIR
##    $LAUNCH  - The name of the executable (can include additional subdirs)
## $PROGSUBDIR - Optional subdirectory. Used to set initial path of run

## If the file is found:
##   * If it is executable, it will be launched.
##   * If it is a Java .jar file, it will be launched with java
## In both cases STDOUT will be captured in $LOGFILE (above), written
## to $PROGDIR. Additional run variables:
##   * $PRERUN     : Will show before running program
##   * $POSTRUN    : Will show after running
##   * $NOREDIRECT : Allows STDOUT to stream to terminal

## If the launcher is not found, then the installer directory
## $INSTROOT (above) will be checked to see if the instal file
## $INSTNAME can be found in directory $INSTDIR. If those variables
## are set and the installer is found:
##   * If it is a .sh it will be run
##   * If a zip/bz2/bzip2/xz it will be extracted
## Additional installation variables
##   * INSTRENAME  : set to "foo/bar", will try to rename 'foo' to 'bar'
##                   The 'from' part can contain '*' wildcards
##   * INSTAPT     : will show the contents as suggested libraries
##   * INSTHELP    : will suggest contents as installation help source
##   * INSTSAVEDIR : will be moved to Documents/GameFiles then symlinked
##   * INSTICON    : custom icon file name (basename) for launcher
##   * INSTFUNCTON : custom function that runs after installation
##   * WINETARGET  : Subfolder generated on your Wine C: drive by installation 

## Copyright (C) 2017 Charles A. Tilford
##   Where I have used (or been inspired by) public code it will be noted

LICENSE_GPL3="

    This program is free software: you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/

"

## script folder: https://stackoverflow.com/a/246128
myLaunchDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$myLaunchDir/../../generalUtilities/_backupFunctions.sh"


# Testing the suffix of a file:
# https://stackoverflow.com/a/965072

function launcherHelp {
    msg "$FgBlue" "\nThis is a launcher file for \"$PROGDIR\""
    if [[ -n "$INSTDIR" ]]; then
        msg "$FgCyan" "  It can auto-install the program"
        [[ -z "$WINETARGET" ]] || msg "$FgCyan" "    ... using Wine to do so"
    fi
    [[ -z "$INSTSAVEDIR" ]] || msg "$FgCyan" "  It will normalize save file location for you"
    msg "$FgBlue" "\nYou can pass it the following arguments:"
    msg "$FgCyan" "
      help - Show this help
  shortcut - Will make a desktop shortcut for you
      save - Move save files to a known location, link to expected location
    backup - Will backup game files, if needed and in a known location
  linkwine - Special follow up command to link wine directories
"
}

function find_and_run_executable {

    if [[ `hasParam "$1" "run"` ]]; then
        ## Explicit request to run the game - just move on from elif block
        ""
    elif [[ `hasParam "$1" "help"` ]]; then
        ## Show help
        launcherHelp; return
    elif [[ `hasParam "$1" "backup"` ]]; then
        ## Make the shortcut
        backupGameFiles; return
    elif [[ `hasParam "$1" "shortcut"` || `hasParam "$1" "desktop"` ]]; then
        ## Make the shortcut
        desktopIcon; return
    elif [[ `hasParam "$1" "linkwine"` || `hasParam "$1" "winelink"` ]]; then
        ## Link the wine directory to the Progams directory
        linkWine
        return
    elif [[ `hasParam "$1" "save"` ]]; then
        ## Move the save files to a standard location
        saveLocation; return
    elif [[ ! -z "$1" ]]; then
        ## Parameters were passed, but we don't know what they are
        err "Unrecognized parameters:"
        err "  $1  "
        launcherHelp; return
    fi
    
    if [[ ! -d "$GAMEDIR" ]]; then
        msg "$FgRed" "
Game directory not found, expected at:
  $GAMEDIR
  This can be a symlink, if desired.
"
        countdown 15
        return
    fi

    runGame

    ## Nothing found. Can we install?
    if [[ -z "$TRIEDINSTALL" ]]; then
       installGame
       return
    fi
    
    ## Nothing found in any of the paths:
    msg "$FgRed" "
Failed to find executable in $GAMEDIR
  Looked in: $PROGDIR
        For: $LAUNCH
"
    countdown 15
}

function runGame {

    EXECUTABLE="$GAMEDIR/$PROGDIR"
    [[ -z "$PROGSUBDIR" ]] || EXECUTABLE="$EXECUTABLE/$PROGSUBDIR"
    EXECUTABLE="$EXECUTABLE/$LAUNCH"
    [[ -s "$EXECUTABLE" ]] || return
    extSfx="${LAUNCH##*.}"

    ## The executable appears to be present
    TRIEDINSTALL="Already installed"
    
    ## Show any pre-run messages:
    [[ -z "$PRERUN" ]] || msg "$FgMagenta" "$PRERUN"

    customRunFunction

    LOG="$GAMEDIR/$PROGDIR/$LOGFILE";

    echo "## Launcher log file" > "$LOG"
    echo "##   "`date` >> "$LOG"
    echo "##   Running: $EXECUTABLE" >> "$LOG"

    if [[ "$extSfx" == 'exe' ]]; then
        echo "##          : With "`wine --version` >> "$LOG"
        echo "#################################################" >> "$LOG"
        runWine
    elif [[ -x "$EXECUTABLE" ]]; then
        echo "#################################################" >> "$LOG"
        runExecutable
    else
        ## Not an executable. What is the extension?
        ##     https://stackoverflow.com/a/965069
        if [[ "$extSfx" == 'jar' ]]; then
            echo `java -version` >> "$LOG"
            echo "#################################################" >> "$LOG"
            runJava
        else
            msg "$FgRed" "  Command exists but is not executable; run:
    chmod u+x \"$EXECUTABLE\""
        fi
    fi

    backupGameFiles # Backup files to server, if save path is known

    ## Show any post-run messages:
    [[ -z "$POSTRUN" ]] || msg "$FgMagenta" "$POSTRUN"
    
    countdown 30
    exit
}

function runExecutable {
    msg "$FgGreen" "  Running $EXECUTABLE"
    cd "$GAMEDIR/$PROGDIR";
    ## If an additional subdirectory is specified, move there
    [[ -z "$PROGSUBDIR" ]] || cd "$PROGSUBDIR"

    set_title "Run $PROGDIR";
    LogNote=""
    if [[ -z "$NOREDIRECT" ]]; then
        ## Capture log to file
        "./$LAUNCH" "$LAUNCHARGS" &>> "$LOG"
        LogNote=" LogFile:\n  less -S \"$LOG\""
    else
        ## Log to STDOUT
        "./$LAUNCH" "$LAUNCHARGS"
    fi
    msg "$FgCyan" "  Launcher finished.$LogNote\n"
}

function runWine {
    msg "$FgGreen" "  Wine launch of $EXECUTABLE"
    cd "$GAMEDIR/$PROGDIR/"
    ## If an additional subdirectory is specified, move there
    [[ -z "$PROGSUBDIR" ]] || cd "$PROGSUBDIR"

    set_title "Wine $PROGDIR";
    LogNote=""
    if [[ -z "$NOREDIRECT" ]]; then
        ## Capture log to file
        wine "$LAUNCH" &>> "$LOG"
        LogNote=" LogFile:\n  less -S \"$LOG\""
    else
        ## Log to STDOUT
        wine "$LAUNCH"
    fi
    msg "$FgCyan" "  Launcher finished.$LogNote\n"
}

function runJava {
    msg "$FgGreen" "  Running Java file \"$EXECUTABLE\""
    cd "$GAMEDIR/$PROGDIR";
    set_title "Run Java $PROGDIR";
    LogNote=""
    if [[ -z "$NOREDIRECT" ]]; then
        ## Capture log to file
        java -Xmx1024M -Xms1024M -jar "$LAUNCH" &>> "$LOG"
        LogNote=" LogFile:\n  less -S \"$LOG\""
    else
        ## Log to STDOUT
        java -Xmx1024M -Xms1024M -jar "$LAUNCH"
    fi
    msg "$FgCyan" "  Launcher finished.$LogNote\n"
}

function installGame {
    TRIEDINSTALL="CHECKED"

    checkOtherPackages

    if [[ -n "$INSTGIT" ]]; then
        installGit
        return
    fi
    
    if [[ -z "$INSTNAME" ]]; then
        ## No information on where to find installer
        msg "$FgRed" "
Launcher not found
  No guidance given on where to find installer
  Consider setting INSTDIR and INSTNAME in the launcher
"
        echo ""
        return
    fi
    findInstaller
    [[ -z "$installer" ]] && return
        
    cd "$GAMEDIR"
    determineSuffix

    if [[ ! -z "$INSTCOPY" ]]; then
        ## Installation is simply copying the file to a new location
        installCopy
    elif [[ $sfx == "exe" ]]; then
        installWine
    elif [[ $sfx == "sh" ]]; then
        TRIEDINSTALL="SHELL: $installer"
        if [[ -x "$installer" ]]; then
            installShell
        else
            failedNotExecutable
            return
        fi
    elif [[ $sfx == "bz2" || $sfx == "bzip2" ]]; then
        ## bzip archive
        installBzip
    elif [[ $sfx == "gz" ]]; then
        ## gzip archive
        installGzip
    elif [[ $sfx == "tar" ]]; then
        ## uncompressed tar archive
        installTar
    elif [[ $sfx == "xz" ]]; then
        ## xz archive
        installXZ
    elif [[ $sfx == "zip" ]]; then
        ## gzip archive
        installZip
    else
        ## No idea!
        failedUnknown
        return
    fi
    finishInstall
}

function finishInstall {

    ## Rename installed folder, if requested
    autoRename
    ## Run custom post-installation function, if defined
    customInstallFunction

    ## Set the executable as, well, executable. Usually not needed,
    ## but sometimes archives don't have correct permissions
    [[ "$extSfx" != 'jar' && -s "$EXECUTABLE" ]] && chmod u+x "$EXECUTABLE"
    
    desktopIcon
    
    msg "$FgBlack;102" "
Installer finished, attempting launch...
"
    saveLocation
    showComments
    find_and_run_executable
}

function findInstaller {
    ## Check first to see if the installer is in ~/Downloads or
    ## ~/ToFile; If so, use one of those.
    TryDir[0]="$HOME/Downloads"
    TryDir[1]="$HOME/ToFile"
    if [[ ! -z "$INSTDIR" ]]; then
        ## Also use INSTDIR as default location, if it has been set by
        ## the launcher
        isAbsPath=`echo "$INSTDIR" | grep '^/'`
        if [[ -z "$isAbsPath" ]]; then
            ## Appears to be a relative path
            TryDir[2]="$INSTROOT"/"$INSTDIR"
        else
            ## Appears to be an absolute path
            TryDir[2]="$INSTDIR"
        fi
    fi

    for dir in "${TryDir[@]}"; do
        ## List by modified date, if there are more than one match
        ## take the most recent one. Allows use of pattern eg:
        ##    myGame_*.sh -> myGame_1.3.sh, myGame_1.4.2.sh etc
        installer=`ls -1t "$dir"/$INSTNAME 2>/dev/null | head -n1 `
        [[ -z "$installer" ]] || break # Take first example we find
    done
    
    if [[ -z "$installer" ]]; then
        ## Installer not found
        msg "$FgRed" "
Could not find installer '$INSTNAME' in:
  ${TryDir[*]}"
        echo ""
    fi
}

function determineSuffix {
    ##  Lower case in bash: https://stackoverflow.com/a/2264537
    ## Parameter Expansion: https://stackoverflow.com/a/965069
    sfx=`echo "${installer##*.}" | tr '[:upper:]' '[:lower:]'`
    ## Also see if this looks like a TAR archive
    unTar=`isTarArchive "$installer"`
}

function isTarArchive {
    isTar=`echo "$1" | grep -i '\.tar\.'`
    unTarLine=""
    [[ -z "$isTar" ]] || unTarLine=" | tar -xvf -"
    echo "$unTarLine"
}

function installCopy {
    ## Installation is just copying a file
    gp="$GAMEDIR/$PROGDIR"
    mkdir -p "$gp"
    msg ""
    msg "$FgMagenta" "
Copying executable $EXECUTABLE to:
  $gp
"
    cp "$INSTDIR/$LAUNCH" "$EXECUTABLE"
}

function installShell {
    msg "$FgMagenta" "
Preparing to install:
  $installer
  If asked for a location, use: $GAMEDIR
           Subfolder should be: $PROGDIR
"
    $installer
}

function installWine {
    Pwd=`pwd`
    cDrive="$GAMEDIR/drive_c"
    if [[ ! -d "$cDrive" ]]; then
        defLoc="$HOME/.wine/drive_c"
        msg "$FgRed" "
Wine's C:/ drive is expected to be at:
  $cDrive
  It was not found, and is likely here:
    $defLoc
  Set up symlinks between the two locations, that is one of:
    mv  \"$defLoc\" \"$cDrive\" && ln -s  \"$cDrive\" \"$defLoc\"
  or:
    ln -s \"$defLoc\"  \"$cDrive\"
"
        return
    fi

    ## Wine wants files to be 'on' drive_c. For GOG, the installer is
    ## often a small exe plus one or more .bin files. So we will make
    ## a temporary symlink to the installer directory in C:/
    cd "$cDrive"
    tmpLnk="TempLinkForInstallation"
    instDir=`dirname "$installer"`
    instExe=`basename "$installer"`
    ln -s "$instDir" "$tmpLnk"
    # Now run the installer
    msg "$FgMagenta" "
Launching installer in wine:
  $installer
  Allow installer to use default installation directories
"
    wine "$tmpLnk/$instExe"
    rm "$tmpLnk" # Remove the symlink
    linkWine
    
    cd "$Pwd" # Return to prior directory
}

function linkWine {
    cDrive="$GAMEDIR/drive_c"
    if [[ -z "$WINETARGET" ]]; then
        msg "$FgRed" "
The launcher has not set the \$WINETARGET variable
  This defines where the file should be created after wine runs the installer
  * Inspect c_drive to determine where the program has been installed
  * Set WINETARGET='where/you/found/it'
  * run: $0 linkwine
  Until this is updated, the program will not run (at least by the launcher)
"
        return
    fi
    
    wineTarg="$cDrive/$WINETARGET"
    gp="$GAMEDIR/$PROGDIR"

    if [[ ! -d "$wineTarg" ]]; then
        msg "$FgRed" "
Could not find the wine target directory at:
  $wineTarg
"
        return
    fi

    if [[ -L "$gp" ]]; then
        ## The standardized program directory is already a symlink
        chk=`readlink -f "$gp"`
        wtc=`readlink -f "$wineTarg"`
        if [[ "$chk" == "$wtc" ]]; then
            msg "$FgCyan" "Symlink ok: $gp"
        else
            err "Symlink exists, but points to unexpected location
   Link At: $gp
   Desired: $wtc
  Existing: $chk
"
        fi
    elif [[ -d "$gp" ]]; then
        ## The program directory is an actual directory
        msg "$FgRed" "
I want to link:
  $wineTarg
  to:
  $gp
  ... but that target is already a directory. It should be a link.
  Please resolve?
"
        return
    else
        ## Make a symlink in the game directory to the C:/ location of the game:
        ln -s "$wineTarg" "$gp"
        msg "$FgCyan" "Symlink to C:/ created: $gp"
    fi
    desktopIcon
    saveLocation
    showComments
}

function installGit {
    TRIEDINSTALL="git archive: $INSTGIT"
    msg "$FgMagenta" "
Cloning git archive:
  $INSTGIT
"
    cd "$GAMEDIR"
    git clone "$INSTGIT"
    finishInstall
}

function installBzip {
    TRIEDINSTALL="BZIP2 Archive: $installer"
    msg "$FgMagenta" "
Preparing to extract:
  $installer
"
    ## Extracting Bzip: https://superuser.com/a/480951
    cmd="bzip2 --stdout --verbose --decompress --keep \"$installer\" $unTar"
    ## Command literal with eval: https://stackoverflow.com/a/2355242
    eval "$cmd"
}

function installGzip {
    TRIEDINSTALL="GZIP Archive: $installer"
    msg "$FgMagenta" "
Preparing to extract:
  $installer
"
    ## Extracting Bzip: https://superuser.com/a/480951
    cmd="gzip --stdout --verbose --decompress --keep \"$installer\" $unTar"
    ## Command literal with eval: https://stackoverflow.com/a/2355242
    eval "$cmd"
}

function installTar {
    ## For 'pure' TAR archives; That is, without any other compression
    ## (weird that people do this...)
    TRIEDINSTALL="TAR Archive: $installer"
    msg "$FgMagenta" "
Preparing to extract:
  $installer
"
    ## Extracting Bzip: https://superuser.com/a/480951
    cmd="tar -xvf \"$installer\""
    ## Command literal with eval: https://stackoverflow.com/a/2355242
    eval "$cmd"
}

function installZip {
    TRIEDINSTALL="ZIP Archive: $installer"
    msg "$FgMagenta" "
Preparing to extract:
  $installer
"
    ## Extracting Bzip: https://superuser.com/a/480951
    cmd="unzip \"$installer\""
    ## Command literal with eval: https://stackoverflow.com/a/2355242
    eval "$cmd"
}

function installXZ {
    TRIEDINSTALL="XZ Archive: $installer"
    msg "$FgMagenta" "
Preparing to extract:
  $installer
"
    ## Extracting XZ: https://askubuntu.com/a/107976
    ## I am presuming a secondary .tar layer - do folks ever use
    ## .xz on things that aren't tar archives?
    
    cmd="tar xf \"$installer\""
    ## Command literal with eval: https://stackoverflow.com/a/2355242
    eval "$cmd"
}

function failedNotExecutable {
    msg "$FgRed" "
Found installer:
  $installer
  ... but it is not executable. Run:
    chmod u+x "$installer"
"
}

function failedUnknown {
    msg "$FgRed" "
Found installer:
  $installer
  ... but did not know what to do with it.
"
    TRIEDINSTALL="UNKNOWN"
}

function showComments {
    ## Indicate if additional packages are indicated as needed:
    [[ -z "$INSTAPT" ]] || msg "$BgYellow;$FgBlue" "
You may need to install additional libraries / software using:
    sudo apt install $INSTAPT"

    ## Indicate if help (URL, man page, etc) is provided:
    [[ -z "$INSTHELP" ]] || msg "$FgCyan" "Installation Help: $INSTHELP"
    
}

function autoRename {
    [[ -z "INSTRENAME" ]] && return
    ## A variable has been set to rename something. This can be useful
    ## when an archive has a generic name like 'linux' as the
    ## top-level folder
    
    ## String splitting: https://stackoverflow.com/a/918931
    IFS='/' read -ra RenameBits <<< "$INSTRENAME"
    reFrom="${RenameBits[0]}"
    reTo="${RenameBits[1]}"
    ## If 'From' has a wildcard, do a listing with it
    ##   Pattern matching: https://stackoverflow.com/a/231298
    [[ "$reFrom" =~ '*' ]] && reFrom=`ls -1td $reFrom | head -n1`
    
    if [[ -z "$reFrom" || -z "$reTo" ]]; then
        msg "$FgRed" "
The variable INSTRENAME was set, indicating that something should be renamed
  But I only found one part (there should be two separated by '/'):
    $INSTRENAME
  This may cause problems ...
"
        return
    fi

    if [[ ! -e "$reFrom" ]]; then
        msg "$FgRed" "
Rename request
  From: \"$reFrom\"
    To: \"$reTo\"
  But I could not find \"$reFrom\" ...
  This may cause problems ...
"
        return
    fi

    if [[ -e "$reTo" ]]; then
        msg "$FgRed" "
Rename request
  From: \"$reFrom\"
    To: \"$reTo\"

  But \"$reTo\" already exists! Please resolve (renaming, moving
  or deleting the 'To' file), this will almost certainly cause
  problems!
"
        return
    fi

    ## We have identified the "from" file, and the "to" file does not
    ## exist. Rename it:
    mv "$reFrom" "$reTo"
    msg "$FgGreen" "Renamed '$reFrom' to '$reTo'"
}

function countdown {
    sec="$1"
    while [[ "$sec" > 0 ]]; do
        printf "Waiting: \e[1;33m%3d\e[0m\r" "$sec"
        ## Bash math: https://unix.stackexchange.com/a/93030
        sec=`expr "$sec" - 1`
        sleep 1
    done
    echo "                    "
}

function saveLocation {
    if [[ -z "$INSTSAVEDIR" ]]; then
        msg "$FgBlue" "
You may wish to normalize save file location using:
  ~/confFiles/games/makeGameLinks.sh
"
        return
    fi

    ## If this variable is defined, it represents a save file location
    ## that needs to be moved to a standardized location
    [[ -d "$SAVEDIR" ]] || mkdir -p "$SAVEDIR"

    TargDir="$SAVEDIR"/"$PROGDIR"

    isd="$INSTSAVEDIR"
    if [[ ! "$isd" =~ ^/ ]]; then
        ## This appears to be a relative path
        if [[ -z "$WINETARGET" ]]; then
            msg "$FgYellow" "A save directory has been specified:
  $isd
  ... but it is a relative path and I don't know how to make it absolute
"
            return
        else
            isd="$GAMEDIR/drive_c/$WINETARGET/$isd"
        fi
    fi

    if [[ -L "$isd" ]]; then
        tTarg=`readlink -f "$isd"`
        sTarg=`readlink -f "$TargDir"`
        if [[ "$tTarg" == "$sTarg" ]]; then
            msg "$FgCyan" "Game files already linked from\n  $isd"
        else
            err "Game files are linked, but not to expected location:
    File location: $isd
           Target: $tTarg
  Expected Target: $sTarg
"
        fi
        return
    elif [[ -d "$isd" ]]; then
        ## The expected/original location already exists (typical case)
        if [[ -d "$TargDir" ]]; then
            ## So does the normalized location
            BkupDir="$isd"-BKUP
            mv "$isd" "$BkupDir"
            msg "$FgYellow" "[!] Initial (empty) save directory moved to: $BkupDir"
            msg "$FgBlue" "Using normalized game files at: $TargDir"
        else
            ## We have not yet made the normalized location, move the
            ## initial folder there
            mv "$isd" "$TargDir"
            msg "$FgBlue" "Save directory moved to: $TargDir"
        fi
    elif [[ -d "$TargDir" ]]; then
        ## Just acknowledge that we found the prior game files
        msg "$FgBlue" "Using normalized game files at: $TargDir"
    else
        ## Neither the initial directory nor the normalized one exist
        ## - some games don't create the save folder until they're
        ## first run. Create an empty folder in the normalized location
        mkdir -p "$TargDir"
    fi

    ## Finally, put a symlink in the "expected" location pointing to
    ## the normalized one.
    ln -s "$TargDir" "$isd"
    msg "$FgBlue" "Save files linked to standard location in 
  $SAVEDIR
  Symlink in: $isd
"
}

function fallBackPath {
    ## Get a file from one of two locations
    # $1 - file name (basename)
    # $2 - priority directory
    # $3 - fallback directory
    if [[ -s "$2/$1" ]]; then
        fbp="$2/$1"
    elif [[ -s "$3/$1" ]]; then
        fbp="$3/$1"
    else
        ## Failed to find it in either
        fbp=""
    fi
}

function desktopIcon {
    ## Make a desktop launcher
    dtDir="$HOME/Desktop" # For .desktop files
    mkdir -p "$dtDir"
    dt="$dtDir/$PROGDIR".desktop
    [[ -s "$dt" ]] && return  # Do nothing else if it is already there
    iDir="$SAVEDIR/.icons"    # Local icon store
    iSrc="/abyss/Media/iconImages"     # Primary storage
    iBkup="/abyss/Common/ToFile/icons" # But check here first
    defIcon="GenericIcon.png"          # Default icon
    icon=${INSTICON:-"$defIcon"}
    iPath="$iDir/$icon"
    mkdir -p "$iDir"
    if [[ ! -s "$iPath" ]]; then
        ## Make a local copy of the icon
        fallBackPath "$icon" "$iBkup" "$iSrc"
        if [[ -z "$fbp" ]]; then
            ## Failed to find the icon, use the default
            $icon="$defIcon"
            iPath="$iDir/$icon"
            fallBackPath "$icon" "$iBkup" "$iSrc"
        fi
        [[ -z "$fbp" ]] || cp "$fbp" "$iPath" # Copy to local storage if found
    fi

    ## I keep ending up with weird executables...
    exeDir=`readlink -f "$myLaunchDir"` # Launcher directory
    exeExe=`basename "$0"`         # Launcher script name
    Exec="$exeDir/$exeExe" # Absolute launcher path, de-linkified

    ## konsole is *REFUSING* to run in the context of a launcher, at
    ## least in KDE. This causes the launcher to fail when
    ## 'terminal=true'. So I am instead setting Exec to open
    ## gnome-terminal and run the script there. This seems to have
    ## been an issue for a while, with no clear solution:
    ##  https://forums.linuxmint.com/viewtopic.php?t=231043

    ## https://standards.freedesktop.org/desktop-entry-spec/latest/ar01s05.html
    echo "[Desktop Entry]
Name=$PROGDIR
Comment=Launch $PROGDIR
Exec=gnome-terminal -e $Exec
Type=Application
#Terminal=true
Path=$GAMEDIR/$PROGDIR
Icon=$iPath
" > "$dt"
    chmod +x "$dt"
    chmod g-w "$dt"
    msg "$FgMagenta" "Desktop launcher created:\n  $dt"

    ## In KDE Plasma, in order to see launchers on the desktop it
    ## needs to be configured as "Folder View":
    ##   Right-click on desktop, choose 'Configure Desktop'
    ##   Select 'Wallpaper'
    ##   Set Layout: to "Folder View"
}

function customInstallFunction {
    ## I've tried to codify 'typical' operations as functions that
    ## work off of simple environment variables, but sometimes more
    ## esoteric steps are needed. Check to see if a custom
    ## installation function has been defined

    ## Check if function is set: https://stackoverflow.com/a/85903
    funcSet=`type -t INSTFUNCTION`
    [[ "$funcSet" == "function" ]] || return

    INSTFUNCTION
}

function customRunFunction {
    funcSet=`type -t RUNFUNCTION`
    [[ "$funcSet" == "function" ]] || return

    RUNFUNCTION
}

function backupGameFiles {
    ## If INSTSAVEDIR is not set, presume we have not normalized the save path
    [[ -z "$INSTSAVEDIR" ]] && return
    SrcFolder="$SAVEDIR/$PROGDIR"
    msg "$BgBlue;$FgYellow" "Backing up... $SrcFolder"
    if [[ -z "$DORSYNC" ]]; then
        archiveFolder "$SrcFolder" "GameFiles"
    else
        rsyncFolder "$SrcFolder" "GameFiles"
    fi
}

function checkOtherPackages {
    checkAptPackages
}

function checkAptPackages {
    chkDp=`which dpkg`
    if [[ -z "$chkDp" ]]; then
        ## Ignore if dpkg is not present
        [[ -n "$APTPACKAGES" ]] && msg "$BgYelow" "
APT packages are specified but your system does not seem to support apt
  You may need to install the appropriate counterparts for your system:
$APTPACKAGES
"
        return
    fi
    [[ -z "$APTPACKAGES" ]] && return # nothing required anyway

    msg "$FgCyan" "Checking for system requirements..."
    sudoAlert=""
    ## Split string on newlines: https://stackoverflow.com/a/19772067
    IFS=$'\n' read -rd '' -a PKGLIST <<< "$APTPACKAGES"
    for pkgname in "${PKGLIST[@]}"; do
        stat=`dpkg -s "$pkgname" 2> /dev/null | grep '^Status' | grep 'installed'`
        if [[ -n "$stat" ]]; then
            msg "$FgGreen;$BgWhite" "  Installed: $pkgname  "
            continue
        fi
        ## It looks like we need to install the package
        if [[ -z "$sudoAlert" ]]; then
            msg "$FgMagenta" "  Some packages need to be installed - you may be prompted for your sudo password"
            sudoAlert='Done'
        fi
        msg "$FgYellow;$BgWhite" "  Required: $pkgname  "
        sudo apt-get -y install "$pkgname"
    done
    
}
