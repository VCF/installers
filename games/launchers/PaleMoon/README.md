### Pale Moon Extensions

Firefox extensions that work with Pale Moon. These are all older
builds of the extensions, compiled before the Australis change to
Firefox. Most are from [AMO][AMO], a few from Pale Moon's addons, and
some from internal updates.

Mozilla has pushed through several changes both to the UI and how
Firefox interacts with extensions. These changes have broken my
workflow to the point that it has become painful to use Firefox, and
I've actually lost data (Tiddlywiki reporting succesful save to disk,
when it has not happened). The core addons I consider critical are:

#### Incompatible with FF57+

* [Tab Mix Plus][TMP] - Excellent tab organization and
  customization. I find working with "modern" FF tabs extremely
  painful.
* [TiddlyWiki][TiddlyWiki] - An amazing "self-contained mini wiki". I
  have a lot of information structured in TiddlyWikis, and each
  Firefox update has progressively broken their functionality.
* [GreaseMonkey][GreaseMonkey] - Allows for application of custom user
  scripts. Easily managed as one-script-per-file in version control
  systems. [TamperMonkey][TamperMonkey] works as a WebExtension, but
  by neccesity lacks some of the functionality available to
  GreaseMonkey, and can not be managed as simple files.

#### Compatible options exist for FF57+ but with caveats

* [Stylish][Stylish] - Excellent user-space CSS styles manager. A good
  WebExtensions replacement exists ([Stylus][Stylus]), but it's not
  compatible with Pale Moon. Stylish also utilizes a SQLite database
  that I find easier to manage with file-based CSS styles.
* [NoScript][NoScript] - Must-have security suite (blacklist). A
  WebExtension version is available, but it lacks many of the features
  present in the old extensions.
* [Cookies Exterminator][CE] - Removes cookies once the web page is
  closed, unless the domain is whitelisted. There are other options
  available.

#### Options exist for older and newer versions of Firefox

* [uBlock Origin][uBlock] - A very nice ad blocker.
* [uMatrix][uMatrix] - Powerful firewall-like security tool that
  allows fine-grained control of what resources a web page can access
* [Disable Ctrl-Q][CtrlQ] - Because I seem to hit it at the worst moment

[AMO]: https://addons.mozilla.org/en-US/firefox/
[TMP]: https://addons.mozilla.org/en-US/firefox/addon/tab-mix-plus/
[Stylish]: https://addons.mozilla.org/en-US/firefox/addon/stylish/
[Stylus]: https://addons.mozilla.org/en-US/firefox/addon/styl-us/
[TiddlyWiki]: https://tiddlywiki.com/
[uBlock]: https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
[uMatrix]: https://addons.mozilla.org/en-US/firefox/addon/umatrix/
[NoScript]: https://addons.mozilla.org/en-US/firefox/addon/noscript/
[GreaseMonkey]: https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/
[TamperMonkey]: https://addons.mozilla.org/en-US/firefox/addon/tampermonkey/
[CtrlQ]: https://addons.mozilla.org/en-us/firefox/addon/disable-ctrl-q-shortcut/
[CE]: https://addons.mozilla.org/en-US/firefox/addon/cookies-exterminator/
[SDC]: https://addons.mozilla.org/en-US/firefox/addon/self-destructing-cookies/
