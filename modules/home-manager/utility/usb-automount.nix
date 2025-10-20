{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.usb-automount.enable {
    services.udiskie.enable = true;
  };
}
