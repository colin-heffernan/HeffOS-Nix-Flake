{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.heffos-home.entertainment.music.spotify.enable = lib.mkEnableOption "Spotify";

  config = lib.mkIf config.heffos-home.entertainment.music.spotify.enable {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
