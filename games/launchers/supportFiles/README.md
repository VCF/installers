_Support files that may be needed by other installers_

### gacutil-net40.tar.bz2

88kb file downloaded from [MediaFire][dotnet40] on 23 Feb 2019, per instruction
from `winetricks dotnet40`. This appears to be fully kosher - the file
has been present on MediaFire since Jan 2012, and [VirusTotal][vtdn40]
is unalarmed. I'm rather uncomfortable that part of the Wine
installation includes a file hosted on MediaFire, of all places, so I
am storing here to track a static copy of the file.

Note that your Wine version must be set to `Windows XP` to instsall
`dotnet40`, otherwise the DLL `mscoree.dll` will not be installed (via
[WineHQ][whqdn40]). You can return the version to a desired one after
installation. If you neglect to do this on the first installation, you
can run `winetricks --force dotnet40` to force a repair.


[dotnet40]: http://www.mediafire.com/file/v8rw5h1ra7maod4/gacutil-net40.tar.bz2
[vtdn40]: https://www.virustotal.com/#/file/fc349f87483677edbe901433aaa9093da957cf9cdb18c7c92df27330f5f0070b/detection
[whqdn40]: https://appdb.winehq.org/objectManager.php?sClass=version&iId=17886
