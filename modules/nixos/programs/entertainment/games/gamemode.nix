{
  config,
  lib,
  ...
}: {
  options.heffos.entertainment.games.gamemode.enable = lib.mkEnableOption "GameMode";

  config = lib.mkIf config.heffos.entertainment.games.gamemode.enable {
    programs.gamemode = {
      enable = true;
      settings.general.inhibit_screensaver = 0;
    };
  };
}
