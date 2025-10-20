{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.system.usb-automount.enable {
    services.udiskie.enable = true;
  };
}
