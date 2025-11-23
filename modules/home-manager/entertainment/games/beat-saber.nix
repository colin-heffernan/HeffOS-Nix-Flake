{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.entertainment.games.beat-saber.enable = lib.mkEnableOption "Beat Saber utilities";

  config = lib.mkIf config.heffos-home.entertainment.games.beat-saber.enable {
    home.packages = with pkgs; [
      bs-manager
    ];
  };
}
