
// General layout:
user_pref("browser.uiCustomization.state", {"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","umatrix_raymondhill_net-browser-action","urlbar-container","stop-reload-button","search-container","downloads-button","_e4a8a97b-f2ed-450b-b12d-ee082ba24781_-browser-action","fxa-toolbar-menu-button"],"toolbar-menubar":["menubar-items","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action","firefox_tampermonkey_net-browser-action","ublock0_raymondhill_net-browser-action","torbutton-button","customizableui-special-spring10","customizableui-special-spring11","customizableui-special-spring12","security-level-button","new-identity-button","panic-button"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["https-everywhere-eff_eff_org-browser-action","ublock0_raymondhill_net-browser-action","umatrix_raymondhill_net-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action","developer-button","_e4a8a97b-f2ed-450b-b12d-ee082ba24781_-browser-action","firefox_tampermonkey_net-browser-action"],"dirtyAreaCache":["nav-bar","toolbar-menubar","PersonalToolbar","TabsToolbar"],"currentVersion":16,"currentTorVersion":1,"newElementCount":13});

// Initial start page
user_pref("browser.startup.homepage", "");
// Find-as-you-type
user_pref("accessibility.typeaheadfind", true); 
// ?
user_pref("accessibility.typeaheadfind.flashBar", 0);
// ?
user_pref("browser.contentblocking.category", "standard");

// Warn the user if quitting out of the browser
user_pref("browser.sessionstore.warnOnQuit", true);
// ?
user_pref("browser.ctrlTab.migrated", true);
// ?
user_pref("browser.ctrlTab.recentlyUsedOrder", false);
// New tabs go next to opening tabs
user_pref("browser.tabs.insertRelatedAfterCurrent", true);
// Searches load in a new background tab
user_pref("browser.search.context.loadInBackground", true);

// 
user_pref("browser.search.useDBForOrder", true);
// 
user_pref("browser.search.widget.inNavBar", true);
// 
user_pref("devtools.performance.recording.interval", 1000);
//
user_pref("browser.urlbar.matchBuckets", "browser.urlbar.matchBuckets");

//
user_pref("extensions.torbutton.launch_warning", false);
// Don't maximize Tor, kids.
user_pref("extensions.torbutton.maximize_warnings_remaining", false);
//
user_pref("extensions.torbutton.security_slider_migration", 1);
//
user_pref("extensions.torbutton.show_slider_notification", false);
//
user_pref("extensions.torlauncher.prompt_at_startup", false);
//
user_pref("extensions.torlauncher.should_remove_meek_helper_profiles", false);
//
user_pref("intl.accept_languages", "en-US, en");
//
user_pref("media.autoplay.enabled", false);
//
user_pref("ui.key.menuAccessKeyFocuses", false);

// 
// Highlight all on-screen matches
user_pref("findbar.highlightAll", true);
// 
user_pref("media.webaudio.enabled", true);
//
user_pref("browser.newtabpage.activity-stream.topSitesRows", 4);

// ****************************************************************8
// Trying to fully turn off autoplay
// https://sites.google.com/view/a-bit-better-privacy/stop-firefox-video-autoplay
user_pref("dom.media.autoplay.autoplay-policy-api", true);
user_pref("media.autoplay.allow-extension-background-pages", false);
user_pref("media.autoplay.allow-muted", false);
user_pref("media.autoplay.blackList-override-default", true);
user_pref("media.autoplay.block-event.enabled", true);
user_pref("media.autoplay.block-webaudio", true);
user_pref("media.autoplay.default", 5);
user_pref("media.autoplay.enabled", false);
user_pref("media.block-autoplay-until-in-foreground", false);
user_pref("media.geckoview.autoplay.request", true);


// ****************************************************************8
// Plugins

// 
user_pref("extensions.shownSelectionUI", true);
// 
user_pref("devtools.webextensions.https-everywhere-eff@eff.org.enabled", true);
//
user_pref("extensions.https_everywhere.firstrun_context_menu", false);


// ****************************************************************8
// Various odious FF junk


user_pref("browser.bookmarks.showMobileBookmarks", false);
user_pref("browser.messaging-system.fxatoolbarbadge.enabled", false);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);
user_pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", {});
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines", "");
user_pref("browser.newtabpage.activity-stream.pocketCta", {});
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.onboarding.seen-tourset-version", 4);
user_pref("browser.ping-centre.production.endpoint", "https://example.com");
user_pref("browser.ping-centre.staging.endpoint", "https://example.com");
user_pref("devtools.onboarding.telemetry.logged", true);
user_pref("devtools.whatsnew.enabled", false);
user_pref("devtools.whatsnew.feature-enabled", false);
user_pref("experiments.activeExperiment", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("extensions.pocket.api", "example.com");
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.oAuthConsumerKey","1234");
user_pref("extensions.pocket.site", "example.com");
user_pref("extensions.torbutton.donation_banner_countdown", 0);
user_pref("extensions.torbutton.donation_banner_countdown2", 0);
user_pref("extensions.torbutton.donation_banner_countdown3", 0);
user_pref("extensions.ui.dictionary.hidden", true);
user_pref("extensions.ui.experiment.hidden", true);
user_pref("extensions.ui.locale.hidden", true);
user_pref("general.warnOnAboutConfig", false);
user_pref("identity.fxaccounts.commands.enabled", false);
user_pref("identity.fxaccounts.enabled", false);
user_pref("identity.fxaccounts.remote.profile.uri", "https://example.com");
user_pref("identity.fxaccounts.remote.root", "https://example.com");
user_pref("identity.fxaccounts.service.monitorLoginUrl", "https://example.com");
user_pref("identity.fxaccounts.service.sendLoginUrl", "https://example.com");
user_pref("identity.fxaccounts.toolbar.enabled", false);
user_pref("layers.enable-tiles", false);
user_pref("lightweightThemes.persisted.footerURL", false);
user_pref("lightweightThemes.persisted.headerURL", false);
user_pref("marionette.prefs.recommended", false);
user_pref("network.prefetch-next", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("toolkit.telemetry.server", "https://example.com");

// Revisit? //

// Turn off warning when closing multiple tabs
// user_pref("browser.tabs.warnOnClose", false);
//
// user_pref("dom.network.enabled", false);

