{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.spotify.enable = lib.mkEnableOption "Spotify";

  config = lib.mkIf config.heffos.entertainment.spotify.enable {
    environment.systemPackages = with pkgs; [
      spotify
    ];
  };
}
