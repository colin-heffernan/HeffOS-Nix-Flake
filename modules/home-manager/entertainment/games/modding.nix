{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.entertainment.games.modding.enable = lib.mkEnableOption "game modding tools";

  config = lib.mkIf config.heffos-home.entertainment.games.modding.enable {
    home.packages = with pkgs; [
      # steamtinkerlaunch
      r2modman
    ];
  };
}
