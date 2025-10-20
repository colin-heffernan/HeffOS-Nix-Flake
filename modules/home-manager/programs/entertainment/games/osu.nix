{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.entertainment.games.osu.enable = lib.mkEnableOption "osu!lazer";

  config = lib.mkIf config.heffos-home.entertainment.games.osu.enable {
    home.packages = with pkgs; [
      osu-lazer-bin
    ];
  };
}
