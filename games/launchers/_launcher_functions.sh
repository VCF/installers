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
## $LAUNCHARGS - Optional arguments to pass to the executable
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
##   * APTPACKAGES : Will install the listed pacakges as needed, via apt
##   * INSTAPT     : will show the contents as suggested libraries
##   * INSTHELP    : will suggest contents as installation help source
##   * INSTCOPY    : Not really an installation, just copy the program
##   * INSTSAVEDIR : will be moved to Documents/GameFiles then symlinked
##                   For Wine locations, can begin with 'drive_c/'
##                   'NONE' indicates no dir exists, don't nag about it
##   * DORSYNC     : If set then backup via rsync rather than dated tar.gz
##   * NOAUTOBACK  : Do not automatically backup the save files
##   * INSTICON    : custom icon file name (basename) for launcher
##   * INSTGIT     : A URL to a git repository to clone
##   * INSTFUNCTON : custom function that runs AFTER installation
##   * WINETARGET  : Subfolder generated on your Wine C: drive by installation
##   * WINEARGS    : Switches passed to Wine
##   * INSTTRICKS  : winetricks needed by a Windows program
##   * NOTINTERM   : Do not run program in terminal
##   * RUNFUNCTION : bash function to run before launching program
##   * UNPACKDIR   : If decompressing needs a subfolder created first

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

fileCol=$(ansiStart "$FgMagenta")

cDrive=""

# Testing the suffix of a file:
# https://stackoverflow.com/a/965072

function launcherHelp {
    msg "$FgBlue" "\nThis is a launcher file for \"$PROGDIR\""
    helpTxt="
      help - Show this help
  shortcut - Will make a desktop shortcut for you"
    if [[ -n "$INSTDIR" || -n "$INSTGIT" ]]; then
        msg "$FgCyan" "  It can auto-install the program"
        if [[ -n "$WINETARGET" ]]; then
            msg "$FgCyan" "    ... using Wine to do so"
        helpTxt="$helpTxt
  linkwine - Special follow up command to link wine directories"
        elif [[ -n "$INSTGIT" ]]; then
            msg "$FgCyan" "    ... from a git repository"
         fi
    fi
    unBit="The save directory is unknown, make sure your save files are ok!"
    if [[ -n "$INSTSAVEDIR" && "$INSTSAVEDIR" != 'NONE' ]]; then
        msg "$FgCyan" "  It will normalize save file location for you"
        helpTxt="$helpTxt
      save - Move save files to a known location, link to expected location
    backup - Will backup save files, if needed and in a known location"
        [[ -n "$NOAUTOBACK" ]] &&         helpTxt="$helpTxt
             Backups must be run manually - $NOAUTOBACK"
        saveLocation
        SrcFolder="$SAVEDIR/$PROGDIR"
        BckFolder=$(backupSubfolder "$SrcFolder" "GameFiles")
        unBit="Your save files a preserved, if you have run at least once:
               $fileCol'$SrcFolder'
               $fileCol'$BckFolder'$(ansiEnd)
"
    fi
    funcSet=$(type -t INSTFUNCTION)
    if [[ "$funcSet" == "function" ]]; then
        helpTxt="$helpTxt
  custfunc - Re-run post-installation custom function (use only when prompted)"
    fi
        helpTxt="$helpTxt
 uninstall - Remove the program files. $unBit"
    msg "$FgBlue" "\nYou can pass it the following arguments:"
    msg "$FgCyan" "$helpTxt\n"
}

function find_and_run_executable {

    if [[ $(hasParam "$1" "run") ]]; then
        ## Explicit request to run the game - just move on from elif block
        ""
    elif [[ $(hasParam "$1" "help") ]]; then
        ## Show help
        launcherHelp; return
    elif [[ $(hasParam "$1" "backup") ]]; then
        ## Run a backup
        backupGameFiles; return
    elif [[ $(hasParam "$1" "shortcut") || $(hasParam "$1" "desktop") ]]; then
        ## Make the shortcut
        desktopIcon; return
    elif [[ $(hasParam "$1" "linkwine") || $(hasParam "$1" "winelink") ]]; then
        ## Link the wine directory to the Progams directory
        linkWine
        return
    elif [[ $(hasParam "$1" "custfunc") ]]; then
        ## Run the custom installation function again
        msg "$FgMagenta" "Re-running custom installation function..."
        customInstallFunction
        return
    elif [[ $(hasParam "$1" "save") ]]; then
        ## Move the save files to a standard location
        saveLocation; return
    elif [[ $(hasParam "$1" "uninstall") ]]; then
        ## Uninstall the program
        uninstallGame; return
    elif [[ ! -z "$1" ]]; then
        ## Parameters were passed, but we don't know what they are
        err "Unrecognized parameters:"
        err "  $1  "
        launcherHelp; return
    fi
    
    if [[ ! -d "$GAMEDIR" ]]; then
        msg "$FgRed" "
Program directory not found, expected at:
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

    cd "$GAMEDIR/$PROGDIR";
    ## If an additional subdirectory is specified, move there
    [[ -z "$PROGSUBDIR" ]] || cd "$PROGSUBDIR"

    echo "## Launcher log file" > "$LOG"
    echo "##   $(date)" >> "$LOG"
    echo "##  Location: $(pwd)" >> "$LOG"
    echo "##   Running: $EXECUTABLE" >> "$LOG"

    if [[ "$extSfx" == 'exe' ]]; then
        wineDriveC
        echo "##          : With $(wine --version)" >> "$LOG"
        echo "##          : Architecture $wineArch Prefix $winePfx" >> "$LOG"
        echo "#################################################" >> "$LOG"
        runWine
    elif [[ -x "$EXECUTABLE" ]]; then
        echo "#################################################" >> "$LOG"
        runExecutable
    else
        ## Not an executable. What is the extension?
        ##     https://stackoverflow.com/a/965069
        if [[ "$extSfx" == 'jar' ]]; then
            runJava
        else
            msg "$FgRed" "  Command exists but is not executable; run:
    chmod u+x \"$EXECUTABLE\""
        fi
    fi
    
    ## Backup files to server, if save path is known and NoAutoBackup
    ## flag is not set
    if [[ -z "$NOAUTOBACK" ]]; then
        backupGameFiles
    else
        msg "$FgYellow" "  Automatic backup suppressed: $NOAUTOBACK"
    fi

    ## Show any post-run messages:
    [[ -z "$POSTRUN" ]] || msg "$FgMagenta" "$POSTRUN"
    
    countdown 30
    exit
}

function runExecutable {
    msg "$FgGreen" "  Running $EXECUTABLE"
    [[ -n "$LAUNCHARGS" ]] && msg "$FgGreen" "    Arguments: $LAUNCHARGS"

    set_title "Run $PROGDIR";
    LogNote=""
    if [[ -z "$NOREDIRECT" ]]; then
        ## Capture log to file
        if [[ -n "$LAUNCHARGS" ]]; then
            "./$LAUNCH" "$LAUNCHARGS" &>> "$LOG"
        else
            "./$LAUNCH" &>> "$LOG"
        fi
        LogNote=" LogFile:\n  less -S \"$LOG\""
    else
        ## Log to STDOUT
        if [[ -n "$LAUNCHARGS" ]]; then
            "./$LAUNCH" "$LAUNCHARGS"
        else
            "./$LAUNCH"
        fi
    fi
    msg "$FgCyan" "  Launcher finished.$LogNote\n"
}

function runWine {
    wineDriveC
    msg "$FgGreen" "  Wine launch of $LAUNCH
    in $(pwd)"
    [[ -n "$LAUNCHARGS" ]] && msg "$FgGreen" "    Arguments: $LAUNCHARGS"
    set_title "Wine $PROGDIR";
    WL="$LAUNCH"
    if [[ -n "$WINEARGS" ]]; then
        msg "$FgGreen" "    Wine Args: $WINEARGS"
        WL="$WL $WINEARGS"
    fi
    LogNote=""
    if [[ -z "$NOREDIRECT" ]]; then
        ## Capture log to file

        ## OMG. Some programs are confounded by an empty
        ## parameter. That is, it is not always safe to include
        ## "$LAUNCHARGS" if $LAUNCHARGS is empty, because the empty ""
        ## will upset the executable (eg Cogmind). So I need another
        ## ifelse block
        if [[ -n "$LAUNCHARGS" ]]; then
            WINEARCH="$wineArch" WINEPREFIX="$winePfx" \
                    wine "$WL" "$LAUNCHARGS" &>> "$LOG"
        else
            WINEARCH="$wineArch" WINEPREFIX="$winePfx" wine "$WL" &>> "$LOG"
        fi
        LogNote=" LogFile:\n  less -S \"$LOG\""
    else
        ## Log to STDOUT
        if [[ -n "$LAUNCHARGS" ]]; then
            WINEARCH="$wineArch" WINEPREFIX="$winePfx" \
                    wine "$WL" "$LAUNCHARGS"
        else
            WINEARCH="$wineArch" WINEPREFIX="$winePfx" wine "$WL"
        fi
    fi
    msg "$FgCyan" "  Launcher finished.$LogNote\n"
}

function runJava {
    msg "$FgGreen" "  Running Java file \"$EXECUTABLE\""
    [[ -n "$LAUNCHARGS" ]] && msg "$FgGreen" "    Arguments: $LAUNCHARGS"

    set_title "Run Java $PROGDIR";

    JCMD="$JAVACMD"
    if [[ -n "$JCMD" ]]; then
        ## A specific version of Java has been requested
        chk=$(which "$JCMD")
        if [[ -n "$chk" ]]; then
            msg "$FgGreen" "  Using custom JRE $JCMD"

        else
            msg "$FgRed" "
A request was made to run this program with a specific Java version:
  $JCMD

  ... that is not present. You may need to install it; Search with
  aptitude, for example if 'java-8-openjdk' is suggested, the version
  is 8 and you want to try a search for:

  aptitude search openjdk-8-jre

  If you don't see it installed (there is no 'i' in front of the
  package), you would then run:

  sudo apt-get install openjdk-8-jre

  If you know it is installed, then you can make a symlink from the
  expected location to the installed one.

"
            exit
        fi
    else
        ## Use the default Java
        JCMD="java"
    fi
    
    "$JCMD" -version >> "$LOG"
    echo "#################################################" >> "$LOG"
    
    LogNote=""
    if [[ -z "$NOREDIRECT" ]]; then
        ## Capture log to file
        "$JCMD" -Xmx1024M -Xms1024M -jar "$LAUNCH" \
             "$LAUNCHARGS" &>> "$LOG"
        LogNote=" LogFile:\n  less -S \"$LOG\""
    else
        ## Log to STDOUT
        "$JCMD" -Xmx1024M -Xms1024M -jar "$LAUNCH" "$LAUNCHARGS"
    fi
    msg "$FgCyan" "  Launcher finished.$LogNote\n"
}

function installGame {
    TRIEDINSTALL="CHECKED"

    [[ -n "$PREINST" ]] && msg "$BgYellow" "$PREINST"

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

    ## Switch to the games directory
    cd "$GAMEDIR"
    if [[ -n "$UNPACKDIR" ]]; then
        ## Generally provided when an archive does not define a
        ## top-level containing folder
        if [[ ! -d "$UNPACKDIR" ]]; then
            msg "$FgMagenta" "Creating subdirectory for unpacking: $UNPACKDIR"
            mkdir "$UNPACKDIR"
            cd "$UNPACKDIR"
        fi
    fi
    
    determineSuffix

    if [[ ! -z "$INSTCOPY" ]]; then
        ## Installation is simply copying the file to a new location
        installCopy
    elif [[ $sfx == "exe" ]]; then
        installWine
    elif [[ $sfx == "sh" ]]; then
        TRIEDINSTALL="SHELL: $installer"
        if [[ ! -x "$installer" ]]; then
            ## Installer isn't executable - try to fix:
            chmod u+x "$installer"
            if [[ -x "$installer" ]]; then
                msg "$FgBlue" "  Updated installer to be executable..."
            else
                failedNotExecutable
                return
            fi
        fi
        installShell
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
        ## zip archive
        installZip
    elif [[ $sfx == "appimage" ]]; then
        ## zip archive
        installAppImage
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
    extSfx="${LAUNCH##*.}"
    if [[ "$extSfx" != 'jar' && -s "$EXECUTABLE" ]]; then
        msg "$FgCyan" "Setting launcher to be executable ...
  $EXECUTABLE
"
        chmod u+x "$EXECUTABLE"
    fi
    
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
    TryDir[2]="$HOME/ToFile/GOG Updates/$PROGDIR"
    TryDir[3]="$HOME/ToFile/Humble Updates/$PROGDIR"
    TryDir[4]="$HOME/ToFile/OpenSource Updates/$PROGDIR"
    TryDir[5]="$HOME/installers/scripts/$PROGDIR"
    if [[ ! -z "$INSTDIR" ]]; then
        ## Also use INSTDIR as default location, if it has been set by
        ## the launcher
        isAbsPath=$(echo "$INSTDIR" | grep '^/')
        if [[ -z "$isAbsPath" ]]; then
            ## Appears to be a relative path
            TryDir[6]="$INSTROOT"/"$INSTDIR"
        else
            ## Appears to be an absolute path
            TryDir[6]="$INSTDIR"
        fi
    fi

    for dir in "${TryDir[@]}"; do
        ## List by modified date, if there are more than one match
        ## take the most recent one. Allows use of pattern eg:
        ##    myGame_*.sh -> myGame_1.3.sh, myGame_1.4.2.sh etc
        installer="$(ls -1t "$dir"/$INSTNAME 2>/dev/null | head -n1)"
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

    hasDot="$(echo "$installer" | grep '\.')"
    if [[ -z "$hasDot" ]]; then
        ## This file does not appear to have a suffix
        isExe="$(file "$installer" | grep -i 'executable')"
        if [[ -n "$isExe" ]]; then
            ## Looks to be executable - let's set suffix as "sh"
            sfx="sh"
        else
            ## Not sure what this is ...
            sfx="NoSuffix"
        fi
    else
        sfx=$(echo "${installer##*.}" | tr '[:upper:]' '[:lower:]')
    fi
    ## Also see if this looks like a TAR archive
    unTar=$(isTarArchive "$installer")
}

function isTarArchive {
    isTar=$(echo "$1" | grep -i '\.tar\.')
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
Copying executable $installer to:
  $gp
"
    cp "$installer" "$EXECUTABLE"
}

function installShell {
    msg "$FgMagenta" "
Preparing to install:
  $installer
  If asked for a location, use: $GAMEDIR
           Subfolder should be: $PROGDIR
  Do not let the installer create a launcher, one will be made for you.
"
    ## msg "$BgWhite" "DEBUG: $(pwd)"
    "$installer"
}

function wineDriveC {
    ## Find the location of the "C:" drive in the current Wine
    ## prefix. If it is not found, create the prefix.
    [[ -n "$cDrive" ]] && return 0 # Run this method just once
    
    ## https://www.tldp.org/LDP/abs/html/parameter-substitution.html
    winePfx="${WINEPREFIX:-$HOME/.wine}"
    wineArch="${WINEARCH:-win32}"
    cDrive="$winePfx/drive_c"
    if [[ ! -d "$cDrive" ]]; then
        msg "$FgCyan" "
Establishing new Wine Prefix at:
  $winePfx
  Just click 'OK' when the dialog appears."
        WINEARCH="$wineArch" WINEPREFIX="$winePfx" winecfg
        msg "$FgBlue" "  Done."
    fi
    msg "$FgGreen" "Wine Prefix: $winePfx ($wineArch)"
}

function installWine {
    Pwd="$(pwd)"
    wineDriveC

    if [[ -n "$INSTTRICKS" ]]; then
        ## Request to make some winetricks available
        msg "$FgCyan" "
Installing requested winetricks:
  $INSTTRICKS
"
        wt=$(which winetricks)
        if [[ -z "$wt" ]]; then
            echo "$FgRed" "
The wine helper application `winetricks` does not appear to be installed
  Please install 'winetricks' from your repository
"
            exit
        fi
        WINEARCH="$wineArch" WINEPREFIX="$winePfx" winetricks $INSTTRICKS
        msg "$FgBlue" "  Done."
    fi

    ## Wine wants files to be 'on' drive_c (chroot/jailed?). For GOG,
    ## the installer is often a small exe plus one or more .bin
    ## files. So we will make a temporary symlink to the installer
    ## directory in C:/
    cd "$cDrive"
    tmpLnk="TempLinkForInstallation"
    instDir="$(dirname "$installer")"
    instExe="$(basename "$installer")"
    ln -s "$instDir" "$tmpLnk"
    # Now run the installer
    msg "$FgMagenta" "
Launching installer in wine:
  $installer
  Allow installer to use default installation directories
"
    WINEARCH="$wineArch" WINEPREFIX="$winePfx" \
            wine "$tmpLnk/$instExe"
    rm "$tmpLnk" # Remove the symlink
    linkWine
    
    cd "$Pwd" # Return to prior directory
}

function linkWine {
    wineDriveC

    if [[ -z "$WINETARGET" ]]; then
        msg "$BgRed" "
You need to define the WINETARGET environment variable
  This represents the subfolder in the wine installation with the program.
  Your C: drive is located at:"
        msg "$FgMagenta" "  $cDrive"
        exit
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
        chk=$(readlink -f "$gp")
        wtc=$(readlink -f "$wineTarg")
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

function install_git_custom {
    ## Clone a repository if it's not already there
    gitUser="$1"  
    gitRepo="$2"
    gitUrl="${3:-https://github.com}"
    gitLoc="${4:-$gitRepo}"
    gitArgs="$5"
    ## For example, for "https://megarepo.com/billy/flyMice.git"
    ##   $1 = The user/account = "billy"
    ##   $2 = The repository   = "flyMice"
    ##   $3 = The hosting site = "https://megarepo.com"
    ##   $4 = Directory to clone to = "flyMice" (default repo name)
    ##   $5 = Optional arguments to pass to git
    if [[ -d "$gitLoc" ]]; then
        msg "$FgCyan" "Repo $gitUser/$gitRepo already cloned"
        return
    fi
    msg "$FgMagenta" "Cloning repository $gitUser/$gitRepo"
    git clone $gitArgs "$gitUrl/$gitUser/${gitRepo}.git" "$gitLoc"
    if [[ -d "$gitLoc" ]]; then
        msg "$FgGreen" "  Done."
    else
        msg "$FgRed;$BgYellow" "  Failed to find expected directory $gitLoc  "
    fi
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

function installAppImage {
    TRIEDINSTALL="AppImage: $installer"
    msg "$FgMagenta" "
Preparing to copy:
  $installer
"
    ## AppImages should simply be executables themselves
    ## We need to make the folder to hold it, then just copy the "installer"
    [[ -d "$PROGDIR" ]] || mkdir "$PROGDIR" # Make directory if not present
    cd "$PROGDIR"

    ## Get the basename of the program, then copy to the directory
    bn="$(basename "$installer")"
    cp "$installer" "$bn"

    chmod u+x "$bn" # Make sure it's executable

    if [[ "$bn" != "$LAUNCH" ]]; then
        ## The installer name does match the exectuable - this is
        ## often because the installer has a version number in it
        ln -fs "$bn" "$LAUNCH"
    fi
}

function install_zip_custom {
    ## Unzip a file to a specified location
    ##   $1 = zip source file or URL
    ##   $2 = Optional directory to unpack in
    ##   $3 = Name of extracted folder, if not matching zip archive name
    srcFile="$1"
    outDir="${2:-.}"
    ## https://stackoverflow.com/a/2664746 - extract basename without suffix
    base=${srcFile##*/}
    base=${base%.zip}
    actualName="${3:-$base}"
    expect="$outDir/$actualName"

    if [[ -d "$expect" ]]; then
        ## Directory is there, we'll presume it's already done
        msg "$FgCyan" "Zip archive $base has already been extracted"
        return
    fi
    if [[ "$srcFile" =~ "http" ]]; then
        ## Presume this is a remote URL
        tmp=$(tempfile).zip
        curl "$srcFile" --output "$tmp"
        srcFile="$tmp"
    fi

    msg "$FgMagenta" "Extracting archive: $1"
    unzip "$srcFile" -d "$outDir"
    if [[ -d "$expect" ]]; then
        ## Apparent success
        msg "$FgGreen" "  Extracted to $outDir"
    else
        msg "$FgRed;$BgYellow" "  Failed to find expected directory $expect  "
    fi
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
  ... but it is not executable, and I failed to make it so.
  Read-only file system? You're going to need to run:
    chmod u+x '$installer'
"
}

function failedUnknown {
    msg "$FgRed" "
Found installer:
  $installer
  ... but did not know what to do with a '$sfx' File.
"
    TRIEDINSTALL="UNKNOWN"
}

function uninstallGame {
    hBar="=========================================================="
    msg "$FgRed" "
$hBar
UNINSTALLING PROGRAM: $PROGDIR
$hBar
"
    if [[ -z "$GAMEDIR" ]]; then
        msg "$FgYellow" "Aborting - GAMEDIR must be set"
        return
    fi
    if [[ -z "$PROGDIR" ]]; then
        msg "$FgYellow" "Aborting - PROGDIR must be set"
        return
    fi
    targDir="$GAMEDIR/$PROGDIR"
    saveLocation
    if [[ -z "$UNKNOWNSAVE" ]]; then
        sd="$SAVEDIR/$PROGDIR"
        msg "$FgGreen" "Your save files will be kept at:
  ${fileCol}'$sd'$(ansiStart $FgGreen)
... with the following contents:$(ansiStart $FgCyan)
$hBar
$(ls -lh "$sd")
$hBar"
        echo ""
        SrcFolder="$SAVEDIR/$PROGDIR"
        BckFolder=$(backupSubfolder "$SrcFolder" "GameFiles")
        if [[ -d "$BckFolder" ]]; then
        msg "$FgGreen" "You also have a backup folder at:
  ${fileCol}'$BckFolder'$(ansiStart $FgGreen)
... with the following contents:$(ansiStart $FgCyan)
$hBar
$(ls -lh "$BckFolder")
$hBar"
        else
            msg "$FgYellow" "   - No backup folder was identified -"
        fi
    else
        msg "$FgYellow" "Save files may not be preserved!\n  $UNKNOWNSAVE"
    fi
    
    NEEDDEL=""
    dt="$(desktopPath)"
    [[ -d "$targDir" ]] && NEEDDEL="Y"
    [[ -e "$dt" ]] && NEEDDEL="Y"
    if [[ -z "$NEEDDEL" ]]; then
        msg "$FgGreen" "
    It appears all program files have already been removed
"
        return
    fi

    msg "$FgRed" "
$hBar
The following directory will be COMPLETELY DELETED:
  ${fileCol}$targDir$(ansiStart $FgRed)
$hBar
"
    
    read -p "$(ansiStart $BgYellow) $(ansiStart $FgRed)Do you wish to delete the above directory?$(ansiStart $FgBlue) $(ansiStart $BgWhite)[yes/no]$(ansiEnd) " GODELETE
    if [[ "$GODELETE" != "yes" ]]; then
        msg "$FgGreen" "  UNINSTALL ABORTED. No changes performed"
        return
    fi

    if [[ -d "$targDir" ]]; then
        msg "$FgRed" "Removing program directory:"
        rm -rfv --one-file-system "$targDir"
    else
        msg "$FgCyan" "  Progam directory appears to already be removed"
    fi

    if [[ -e "$dt" ]]; then
        msg "$FgRed" "Removing desktop icon:"
        rm -rv "$dt"
    else
        msg "$FgCyan" "  Desktop icon appears to already be removed"
    fi
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
    [[ -z "$INSTRENAME" ]] && return
    ## A variable has been set to rename something. This can be useful
    ## when an archive has a generic name like 'linux' as the
    ## top-level folder
    
    ## String splitting: https://stackoverflow.com/a/918931
    IFS='/' read -ra RenameBits <<< "$INSTRENAME"
    reFrom="${RenameBits[0]}"
    reTo="${RenameBits[1]}"
    ## If 'From' has a wildcard, do a listing with it
    ##   Pattern matching: https://stackoverflow.com/a/231298
    [[ "$reFrom" =~ '*' ]] && reFrom=$(ls -1td $reFrom | head -n1)
    
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
    while [[ "$sec" -gt 0 ]]; do
        printf "Waiting: \e[1;33m%3d\e[0m\r" "$sec"
        ## Bash math: https://unix.stackexchange.com/a/93030
        sec=$(expr "$sec" - 1)
        sleep 1
    done
    echo "                    "
}

function saveLocation {
    UNKNOWNSAVE="Yes"
    if [[ -z "$INSTSAVEDIR" ]]; then
        msg "$FgBlue" "
If you know the folder that contains save files, please define it with:
   $(ansiStart $FgCyan)INSTSAVEDIR='...'$(ansiStart $FgBlue)
   ... in the launcher script
"
        UNKNOWNSAVE="No path specified"
        return
    fi

    ## Just a flag for no save location being set - prevents the above
    ## message from being emitted
    if [[ "$INSTSAVEDIR" == 'NONE' ]]; then
        UNKNOWNSAVE="Flag set indicating no save files are needed"
        return
    fi
    
    if [[ $INSTSAVEDIR =~ ^drive_c ]]; then
        ## locations starting with 'drive_c' need to be normalized to
        ## the requested Wine prefix
        wineDriveC
        INSTSAVEDIR=$(sed 's#^drive_c#'"$cDrive"'#' <<< "$INSTSAVEDIR")
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
            UNKNOWNSAVE="Unable to resolve requested directory"
            return
        else
            ## The path is relative to a wine directory
            wineDriveC
            isd="$cDrive/$WINETARGET/$isd"
        fi
    fi

    if [[ -L "$isd" ]]; then
        ## The 'original' directory is already a link; Make sure it
        ## already points to the normalized location we want
        tTarg=$(readlink -f "$isd")
        sTarg=$(readlink -f "$TargDir")
        if [[ "$tTarg" == "$sTarg" ]]; then
            msg "$FgCyan" "Save files already linked from
  ${fileCol}'$isd'"
            UNKNOWNSAVE=""
       else
            err "Save files are linked, but not to expected location:
    File location: $isd
           Target: $tTarg
  Expected Target: $sTarg
"
            UNKNOWNSAVE="Linked directory is in unexpected location"
        fi
        return
    elif [[ -d "$isd" ]]; then
        ## The expected/original location already exists (typical case)
        if [[ -d "$TargDir" ]]; then
            ## So does the normalized location
            BkupDir="$isd"-BKUP
            mv "$isd" "$BkupDir"
            msg "$FgYellow" "[!] Initial (empty) save directory moved to: \"$BkupDir\""
            msg "$FgBlue" "Using normalized save files at: \"$TargDir\""
        else
            ## We have not yet made the normalized location, move the
            ## initial folder there
            mv "$isd" "$TargDir"
            msg "$FgBlue" "Save directory moved to: \"$TargDir\""
        fi
    elif [[ -d "$TargDir" ]]; then
        ## Just acknowledge that we found the prior game files
        msg "$FgBlue" "Prior save files found at: \"$TargDir\""
        par=$(dirname "$isd")
        if [[ ! -d "$par" ]]; then
           msg "$FgRed$BgYellow" "
However, the parent directory of the 'original' save directory does not exist:
  $par
Until that directory is generated, a link can not be made to the previous files
You may need to run the program once, and possibly make an initial save.
Once the parent exists, run:
  $0 save
"
        fi
    else
        ## Neither the initial directory nor the normalized one exist
        ## - some games don't create the save folder until they're
        ## first run. Create an empty folder in the normalized location
        mkdir -p "$TargDir"
    fi

    ## Finally, put a symlink in the "expected" location pointing to
    ## the normalized one.
    ln -s "$TargDir" "$isd"
    UNKNOWNSAVE=""
    msg "$FgBlue" "Save files linked to standard location in 
  $SAVEDIR
  Symlink in: \"$isd\"
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

function desktopPath {
    dtDir="$HOME/Desktop" # For .desktop files
    mkdir -p "$dtDir"
    echo "$dtDir/$PROGDIR".desktop
}

function desktopIcon {
    ## Make a desktop launcher
    dt="$(desktopPath)"
    if [[ -s "$dt" ]]; then
        ## Do nothing else if it is already there ... unless the
        ## launcher was made by some other program
        myself="$(basename "$0")"
        isOk=$(grep "$myself" "$dt")
        ## If the launcher refers to the launch script, move on
        [[ -n "$isOk" ]] && return
        ## Otherwise, mv this elsewhere
        dtBkDir="$HOME/Desktop/Original Launchers"
        mkdir -p "$dtBkDir"
        mv "$dt" "$dtBkDir"
    fi
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
            icon="$defIcon"
            iPath="$iDir/$icon"
            fallBackPath "$icon" "$iBkup" "$iSrc"
        fi
        [[ -z "$fbp" ]] || cp "$fbp" "$iPath" # Copy to local storage if found
    fi

    ## I keep ending up with weird executables...
    exeDir="$(readlink -f "$myLaunchDir")" # Launcher directory
    exeExe="$(basename "$0")"              # Launcher script name
    Exec="$exeDir/$exeExe" # Absolute launcher path, de-linkified

    if [[ -z "$NOTINTERM" ]]; then
        ## konsole is *REFUSING* to run in the context of a launcher, at
        ## least in KDE. This causes the launcher to fail when
        ## 'terminal=true'. So I am instead setting Exec to open
        ## gnome-terminal and run the script there. This seems to have
        ## been an issue for a while, with no clear solution:
        ##  https://forums.linuxmint.com/viewtopic.php?t=231043
        Exec="gnome-terminal -e $Exec"
    fi

    ## https://standards.freedesktop.org/desktop-entry-spec/latest/ar01s05.html
    echo "[Desktop Entry]
Name=$PROGDIR
Comment=Launch $PROGDIR
Exec=$Exec
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
    funcSet=$(type -t INSTFUNCTION)
    [[ "$funcSet" == "function" ]] || return

    INSTFUNCTION
}

function customRunFunction {
    funcSet=$(type -t RUNFUNCTION)
    [[ "$funcSet" == "function" ]] || return

    RUNFUNCTION
}

function backupGameFiles {
    ## If INSTSAVEDIR is not set, presume we have not normalized the save path
    [[ -z "$INSTSAVEDIR" ]] && return
    SrcFolder="$SAVEDIR/$PROGDIR"
    if [[ -z "$DORSYNC" ]]; then
        msg "$BgBlue;$FgYellow" "Backing up... $SrcFolder"
        archiveFolder "$SrcFolder" "GameFiles"
    else
        msg "$BgBlue;$FgYellow" "Synchronizing... $SrcFolder"
        rsyncFolder "$SrcFolder" "GameFiles"
    fi
}

function checkOtherPackages {
    checkAptPackages
}

function checkAptPackages {
    chkDp=$(which dpkg)
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
        stat=$(dpkg -s "$pkgname" 2> /dev/null | grep '^Status' | grep 'installed')
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
