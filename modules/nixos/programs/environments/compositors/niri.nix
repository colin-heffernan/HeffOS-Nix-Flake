{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.environments.compositors.niri.enable = lib.mkEnableOption "Niri";

  config = lib.mkIf config.heffos.environments.compositors.niri.enable {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xwayland-satellite
    ];
  };
}
