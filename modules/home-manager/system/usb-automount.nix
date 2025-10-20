{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.heffos.system.usb-automount.enable {
    services.udiskie.enable = true;

    home.packages = with pkgs; [
      udiskie
    ];
  };
}
