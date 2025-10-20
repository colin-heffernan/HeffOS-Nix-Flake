{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.services.usb-automount.enable {
    services.udiskie.enable = true;
  };
}
