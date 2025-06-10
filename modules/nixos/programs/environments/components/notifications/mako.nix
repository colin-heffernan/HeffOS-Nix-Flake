{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.environments.components.notifications.mako.enable = lib.mkEnableOption "Mako";

  config = lib.mkIf config.heffos.environments.components.notifications.mako.enable {
    environment.systemPackages = with pkgs; [
      mako
    ];
  };
}
