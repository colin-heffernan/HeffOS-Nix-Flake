{
  config,
  lib,
  ...
}: {
  options.heffos.environments.display-managers.sddm.enable = lib.mkEnableOption "SDDM";

  config = lib.mkIf config.heffos.environments.display-managers.sddm.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
