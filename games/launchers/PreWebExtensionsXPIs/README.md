### Pre-WebExtensions Extensions

Firefox extensions that work on builds prior to the
[switch to WebExtensions in FF57][FF57]. Mozilla refers to these XPIs
as "Legacy" and as of FF57 no longer supports them. I am not confident
that these older versions will always be available, so am keeping
copies here, downloaded from [AMO][AMO] using the "All Versions"
sections on each add-on's page.

Since the introduction of [Australis][Australis] in 2013, Mozilla has
been pushing changes to both the UI and how Firefox interacts with
extensions. These changes have broken my workflow to the point that it
has become painful to use Firefox, and I've actually lost data
(Tiddlywiki reporting succesful save to disk, when it has not
happened). Some of these changes are motivated by security concerns,
but many are cosmetic, and appear to be designed to make Firefox into
a clone of Google's Chrome browser.

I have used Firefox because I feel I can secure it more easily
([NoScript][NoScript] and [uMatrix][uMatrix]), and for its ability to
fully customize the browser ([Stylish][Stylish],
[GreaseMonkey][GreaseMonkey], [Tab Mix Plus][TMP]). In some cases the
changes have required me to write new scripts to maintain past
customizations, in others they have simply broken them. I am fatigued
trying to maintain the functionality of my past scripts in each new
release of FF.

I initally tried [Palemoon][Palemoon] as an alternative. However, the
developer chose to [flag NoScript as a "breaking" addon][PMWTF]. The
"breaking" behavior was NoScript _doing what it was designed to_ -
preventing Javascript from executing. They claimed this blacklisting
was opt-in and reversible, but on one of my two systems running
Palemoon it was _assuredly not_; I had to disable addon blacklisting
altogether to restore NoScript. Multiple users in the forum pointed
out their same experiences, and were told they were confused and/or
overly emotional. The condescension demonstrated by the developer has
led me to [Waterfox][Waterfox].

The core addons I consider critical are:

#### Incompatible with FF57+

* [Tab Mix Plus][TMP] - Excellent tab organization and
  customization. I find working with "modern" FF tabs extremely
  painful.
* [TiddlyWiki][TiddlyWiki] - An amazing "self-contained mini wiki". I
  have a lot of information structured in TiddlyWikis, and each
  Firefox update has progressively broken their
  functionality. Tiddlywikis require the [TiddlyFox][TiddlyFox]
  extension to allow changes to be saved.
* [GreaseMonkey][GreaseMonkey] - Allows for application of custom user
  scripts. Easily managed as one-script-per-file in version control
  systems. [TamperMonkey][TamperMonkey] works as a WebExtension, but
  by neccesity lacks some of the functionality available to
  GreaseMonkey, and can not be managed as simple files.
* [Classic Theme Restorer][CTR] - Undo the forced UI changes brought
  by Australis.

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

[FF57]: https://blog.mozilla.org/addons/2017/09/28/webextensions-in-firefox-57/
[AMO]: https://addons.mozilla.org/en-US/firefox/
[Palemoon]: https://www.palemoon.org/
[PMWTF]: https://forum.palemoon.org/viewtopic.php?t=19119
[Waterfox]: https://www.waterfoxproject.org/
[TMP]: https://addons.mozilla.org/en-US/firefox/addon/tab-mix-plus/
[Stylish]: https://addons.mozilla.org/en-US/firefox/addon/stylish/
[Stylus]: https://addons.mozilla.org/en-US/firefox/addon/styl-us/
[TiddlyWiki]: https://tiddlywiki.com/
[TiddlyFox]: https://addons.mozilla.org/en-US/firefox/addon/tiddlyfox/
[uBlock]: https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
[uMatrix]: https://addons.mozilla.org/en-US/firefox/addon/umatrix/
[NoScript]: https://addons.mozilla.org/en-US/firefox/addon/noscript/
[GreaseMonkey]: https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/
[CTR]: https://addons.mozilla.org/en-US/firefox/addon/classicthemerestorer/
[Australis]: https://blog.mozilla.org/ux/2013/11/australis-is-landing-in-firefox-nightly/
[TamperMonkey]: https://addons.mozilla.org/en-US/firefox/addon/tampermonkey/
[CtrlQ]: https://addons.mozilla.org/en-us/firefox/addon/disable-ctrl-q-shortcut/
[CE]: https://addons.mozilla.org/en-US/firefox/addon/cookies-exterminator/
[SDC]: https://addons.mozilla.org/en-US/firefox/addon/self-destructing-cookies/
