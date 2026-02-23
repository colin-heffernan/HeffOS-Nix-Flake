{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.communication.stoat.enable = lib.mkEnableOption "Stoat Chat";

  config = lib.mkIf config.heffos-home.communication.stoat.enable {
    home.packages = with pkgs; [
      stoat-desktop
    ];
  };
}
