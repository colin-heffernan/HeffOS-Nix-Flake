{
  config,
  lib,
  ...
}: {
  options.heffos-home.entertainment.games.mangohud.enable = lib.mkEnableOption "MangoHud";

  config = lib.mkIf config.heffos-home.entertainment.games.mangohud.enable {
    programs.mangohud.enable = true;
  };
}
