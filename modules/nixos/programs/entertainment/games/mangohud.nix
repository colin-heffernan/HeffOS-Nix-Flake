{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.mangohud.enable = lib.mkEnableOption "MangoHud";

  config = lib.mkIf config.heffos.entertainment.games.mangohud.enable {
    environment.systemPackages = with pkgs; [
      mangohud
    ];
  };
}
