{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.vr.enable = lib.mkEnableOption "VR support";

  config = lib.mkIf config.heffos.entertainment.games.vr.enable {
    services.wivrn = {
      enable = true;
      openFirewall = true;
      defaultRuntime = true;
      autoStart = true;
      # config.enable = true;
    };
  };
}
