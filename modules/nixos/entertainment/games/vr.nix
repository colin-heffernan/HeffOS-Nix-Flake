{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.vr.enable = lib.mkEnableOption "VR support";

  config = lib.mkIf config.heffos.entertainment.games.vr.enable {
    programs.envision = {
      enable = true;
      openFirewall = true;
    };
  };
}
