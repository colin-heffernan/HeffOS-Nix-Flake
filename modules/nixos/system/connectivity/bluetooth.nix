{
  config,
  lib,
  ...
}: {
  options.heffos.system.connectivity.bluetooth.enable = lib.mkEnableOption "Bluetooth";

  config = lib.mkIf config.heffos.system.connectivity.bluetooth.enable {
    hardware.bluetooth.enable = true;
  };
}
