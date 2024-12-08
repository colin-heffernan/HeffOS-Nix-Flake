{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.osu.enable = lib.mkEnableOption "osu!lazer";

  config = lib.mkIf config.heffos.entertainment.games.osu.enable {
    environment.systemPackages = with pkgs; [
      osu-lazer-bin
    ];
  };
}
