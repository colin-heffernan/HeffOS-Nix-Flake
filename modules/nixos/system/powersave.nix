{
  config,
  lib,
  ...
}: {
  options.heffos.system.powersave.enable = lib.mkEnableOption "power-saving features";

  config = lib.mkIf (!config.heffos.system.powersave.enable) {
    powerManagement.enable = false;
    systemd.targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };
}
