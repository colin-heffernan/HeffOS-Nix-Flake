{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.services.usb-automount.enable = lib.mkEnableOption "auto-mounting for USB drives";

  config = lib.mkIf config.heffos.services.usb-automount.enable {
    services.udisks2.enable = true;

    environment.systemPackages = with pkgs; [
      udiskie
    ];
  };
}
