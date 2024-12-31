{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.compat.translation.enable = lib.mkEnableOption "translation layer software";

  config = lib.mkIf config.heffos.compat.translation.enable {
    environment.systemPackages = with pkgs; [
      stable.bottles
      wineWowPackages.waylandFull
    ];
  };
}
