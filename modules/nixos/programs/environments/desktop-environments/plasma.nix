{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.environments.desktop-environments.plasma.enable = lib.mkEnableOption "KDE Plasma 6";

  config = lib.mkIf config.heffos.environments.desktop-environments.plasma.enable {
    services = {
      xserver = {
        enable = true;
        videoDrivers = ["amdgpu"];
      };
      desktopManager.plasma6.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      ark
      elisa
      gwenview
      okular
      kate
    ];
  };
}
