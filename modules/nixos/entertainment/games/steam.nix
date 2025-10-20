{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf config.heffos.entertainment.games.steam.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
