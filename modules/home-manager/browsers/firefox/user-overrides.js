// *** Arkenfox Overrides ***
user_pref("browser.safebrowsing.downloads.remote.enabled", true); // Disable 0403
// Re-enable session restore
user_pref("browser.startup.page", 3); // 0102
// user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
// user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // 2811 FF128-135
// user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false); // 2812 FF136+
// user_pref("privacy.clearSiteData.historyFormDataAndDownloads", false); // 2820 FF128-135
// user_pref("privacy.clearSiteData.browsingHistoryAndDownloads", false); // 2821 FF136+
// user_pref("privacy.clearHistory.historyFormDataAndDownloads", false); // 2830 FF128-135
// user_pref("privacy.clearHistory.browsingHistoryAndDownloads", false); // 2831 FF136+
// *** Other Stuff ***
// Enable containers
user_pref("privacy.userContext.enabled", true); // Enable containers
user_pref("privacy.userContext.ui.enabled", true); // Enable UI for containers
// Enable vertical tabs
user_pref("sidebar.verticalTabs", true); // Use vertical tabs
user_pref("sidebar.verticalTabs.dragToPinPromo.dismissed", true); // Dismiss vertical tabs popup

