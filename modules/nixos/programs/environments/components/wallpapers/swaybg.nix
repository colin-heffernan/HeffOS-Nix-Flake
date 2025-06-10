{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.environments.components.wallpapers.swaybg.enable = lib.mkEnableOption "SwayBG";

  config = lib.mkIf config.heffos.environments.components.wallpapers.swaybg.enable {
    environment.systemPackages = with pkgs; [
      swaybg
    ];
  };
}
