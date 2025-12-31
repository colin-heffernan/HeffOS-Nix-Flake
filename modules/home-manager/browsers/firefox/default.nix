{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.browsers.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf config.heffos-home.browsers.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles.default = {
        # Add Arkenfox with overrides
        extraConfig = let
          readFiles = f: lib.concatStringsSep "\n" (map builtins.readFile f);
        in
          readFiles [
            "${pkgs.arkenfox-userjs}/user.js"
            "${./user-overrides.js}"
          ];
        extensions.force = true;
      };

      policies = {
        # Disable self-updating
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;

        # Disable unwanted behaviors and features
        DisableAppUpdate = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisableMasterPasswordCreation = true;
        DisablePasswordReveal = true;
        DisablePocket = true; # This is deprecated.
        DisableProfileImport = true;
        DisableProfileRefresh = true;
        DisableSetDesktopBackground = true;
        DisableSystemAddonUpdate = true;
        DisableTelemetry = true;

        # Block about pages
        BlockAboutProfiles = true;
        BlockAboutSupport = true;

        # Modify UI and behavior
        DisplayMenuBar = "never";
        DisplayBookmarksToolbar = "never";
        HardwareAcceleration = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        PrimaryPassword = false;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        NoDefaultBookmarks = true;
        DefaultDownloadDirectory = "${config.xdg.userDirs.download}";
        FirefoxHome = {
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          Stories = false;
          SponsoredPocket = false;
          SponsoredStories = false;
          Snippets = false;
        };
        FirefoxSuggest = {
          WebSuggestions = true;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
        };
        GenerativeAI.Enabled = false;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        SkipTermsOfUse = true;
        SearchBar = "unified";
        SearchEngines = let
          mkUrl = path: "data:image/svg+xml,${lib.escapeURL (builtins.readFile path)}";
        in {
          #nak
          Add = [
            {
              Name = "StartPage";
              URLTemplate = "https://www.startpage.com/sp/search";
              Method = "POST";
              PostData = "query={searchTerms}";
              IconURL = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAADb0lEQVRYhb2VXWgUVxiGv2gtWHrXBqExO2d2z5leWC80ilRKDTHunAPWhEi0gYY2mZkorYm7Z260oCiiFaQ3/RNqG/CvqAheKLSUUgpWqBdCKdbc+XMji4mhmk2MXTdvL9r4U+dsZtasH3x3877v852/IapUuzDHz6HF0/jU1/g10CgEIUq+xoMgxLAf4qIX4ksvj3c6O/FiRa8k1dyMF4IQm/0QV4MQiNkFP4+P+/rw0jOFewN4I9D4PUHwk61xrSePVVWF9+agAo2xqsMfdcnLwU8U7ufQHGhMzkL4dJe9EN3xwrdiga9xq4LZXV/jkK+xsTePZT05LPXzaPvvcBZMOj/EvQ/yWDwzgMZRo4nG0a4+vGrSduYxP9DYF4QoG/QXKoa/349M8O+1ippgb6wlJCIvh25fY8rgs6bS9LuiRJ7GT0SoiwtARORpfG5YhWNGURDifJSoR2NlknAiop5+1Psh7kdczYJR5IcYiRAMJw1/OJDGL1EDdYWGc7R9LyY/+QzlLwYxdfgkcPoscO5H/FYtwMQ9HBmfAMaKwOhfwPBt4GYBuH4ddqQAQBFP1+VqAQCcifADgAaT4HLExyXAfPXM1TSvvTNX6NiQH29bPzC2tr2/uLZ9y/i6joERAHMjJVeGrn79/Q/ncejb09i95yA2fbQHbeu3YsmKjTuTxltc9dqOwv+bOfJno6iRq2ykSKiJVCbbFDc8lWpNM0eORHlZXH5YSVtnO+oPA/mIlVEtMSZfYgt1I8rDFvJWfX3zy5UNMqqFCVU2rESZCXU8lZZvEdHj+1hncXcpE+qg7ci/I8MdBYu78f6KjLv7TSaPYOQ4E3KICfWnLdSdGb935KlY4dMTMaEGZzJN0kzI74hoTiIIW7g7bEeVZg/C/SoJABERNablcsbdC7MFYXEV+6/6JIjIvs2EGmRCFcz7rEYZd0+kuHyPOfKmESLjhlVBTJdlZe1GvibLHPkuE7LLymTVa7Z8nR7b44Xp1sXMUaOG8zBl8WzvM0HEAuXyTebIomElSpaQHTWHaOTStR113wAxmUq7rTWHSHF3AxPqQTSEHGMiu6LmECwjNzEhpwyP1O0UdxfVHoLLbRUeqks1ByAisoQ8YNiK0nMBICKyufzmqbdByHPPDYCI5jIu99lCDTNHFhl3TzQ0rH7lHy2g5RVQKFbLAAAAAElFTkSuQmCC";
              Alias = "";
              Description = "The world's most private search engine";
              SuggestURLTemplate = "https://www.startpage.com/osuggestions?q={searchTerms}";
            }
            {
              Name = "Nix Packages";
              URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              Method = "GET";
              IconURL = mkUrl "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              Alias = "@np";
              Description = "Search for Nix packages";
            }
            {
              Name = "Nix Options";
              URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
              Method = "GET";
              IconURL = mkUrl "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              Alias = "@no";
              Description = "Search for NixOS options";
            }
            {
              Name = "NixOS Wiki";
              URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
              Method = "GET";
              IconURL = mkUrl "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              Alias = "@nw";
              Description = "Search the NixOS wiki";
            }
            {
              Name = "Home-Manager Options";
              URLTemplate = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";
              Method = "GET";
              IconURL = mkUrl "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              Alias = "@hmo";
              Description = "Search for Home-Manager options";
            }
          ];
          Default = "StartPage";
          PreventInstalls = false;
          Remove = [
            "Google"
            "Bing"
            "Amazon.com"
            "eBay"
            "Twitter"
            "Perplexity"
          ];
        };

        # Harden
        EnableTrackingProtection.Category = "strict";
        HttpsOnlyMode = "force_enabled";
        PopupBlocking.Default = false;

        # Automatically install extensions
        ExtensionSettings = let
          amo = slug: "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
        in {
          "uBlock0@raymondhill.net" = {
            # uBlock Origin
            installation_mode = "force_installed";
            install_url = amo "ublock-origin";
            default_area = "navbar";
            private_browsing = true;
          };
          "sponsorBlocker@ajay.app" = {
            # SponsorBlock
            installation_mode = "force_installed";
            install_url = amo "sponsorblock";
            default_area = "menupanel";
            private_browsing = true;
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            # Bitwarden
            installation_mode = "force_installed";
            install_url = amo "bitwarden-password-manager";
            default_area = "navbar";
            private_browsing = true;
          };
          "{7c7590e7-36ec-471d-999e-29bc7d528b18}" = {
            # Catppuccin Mocha - Pink
            installation_mode = "force_installed";
            install_url = amo "catppuccin-mocha-pink";
            private_browsing = true;
          };
        };

        # Automatically configure extensions
        "3rdparty".Extensions = {
          # Extension settings
          "uBlock0@raymondhill.net".adminSettings = {
            # uBlock Origin
            userSettings = rec {
              advancedUserEnabled = true;
              uiTheme = "dark";
              cloudStorageEnabled = lib.mkForce false;
              importedLists = [
                "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
              ];
              externalLists = lib.concatStringsSep "\n" importedLists;
            };
            selectedFilterLists = [
              "ublock-badware"
              "ublock-filters"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "easylist"
              "plowe-0"
              "easyprivacy"
              "urlhaus-1"
              "adguard-spyware-url"
              "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            ];
          };
        };

        # Automatically *uninstall* extensions
        Extensions.Uninstall = [
          "google@search.mozilla.org"
          "bing@search.mozilla.org"
          "amazondotcom@search.mozilla.org"
          "ebay@search.mozilla.org"
          "twitter@search.mozilla.org"
        ];
      };
    };
  };
}
