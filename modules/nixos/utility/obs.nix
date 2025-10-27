{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.obs = {
    enable = lib.mkEnableOption "OBS";
    droidCam = lib.mkEnableOption "Droidcam for OBS";
  };

  config = lib.mkIf config.heffos.utility.obs.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = lib.mkIf config.heffos.utility.obs.droidCam (with pkgs.obs-studio-plugins; [
        droidcam-obs
      ]);
    };
  };
}
