{
  config,
  lib,
  ...
}: {
  options.heffos.system.usb-automount.enable = lib.mkEnableOption "auto-mounting for USB drives";

  config = lib.mkIf config.heffos.system.usb-automount.enable {
    services.udisks2.enable = true;
  };
}
