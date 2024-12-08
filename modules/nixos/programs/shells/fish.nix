{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.shells.fish.enable = lib.mkEnableOption "Fish Shell";

  config = lib.mkIf config.heffos.shells.fish.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        sup = "sudo nixos-rebuild-switch --flake ~/Repos/HeffOS-Nix-Flake#${config.networking.hostName}";
        fup = "nix flake update";
      };
    };
  };
}
