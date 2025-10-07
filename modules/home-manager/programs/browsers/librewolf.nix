{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.browsers.librewolf.enable {
    programs.librewolf = {
      enable = true;
      policies.ExtensionSettings = {
        # Use this block if this policy overrides LibreWolf's automatic installation of uBO
        # "uBlock0@raymondhill.net" = {
        #   installation_mode = "force_installed";
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        #   default_area = "navbar";
        #   private_browsing = true;
        # };
        "sponsorBlocker@ajay.app" = { # SponsorBlock
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          default_area = "menupanel";
          private_browsing = true;
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = { # Bitwarden
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          default_area = "navbar";
          private_browsing = true;
        };
        "{7c7590e7-36ec-471d-999e-29bc7d528b18}" = { # Catppuccin Mocha - Pink
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-pink/latest.xpi";
          private_browsing = true;
        };
      };
      settings = {
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.downloads" = false;
      };
    };
  };
}
