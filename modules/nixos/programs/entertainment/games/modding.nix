{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.modding.enable = lib.mkEnableOption "game modding tools";

  config = lib.mkIf config.heffos.entertainment.games.modding.enable {
    environment.systemPackages = with pkgs; [
      steamtinkerlaunch
      r2modman
    ];
  };
}
