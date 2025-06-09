{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.terminal-emulators.kitty.enable = lib.mkEnableOption "Kitty term";

  config = lib.mkIf config.heffos.terminal-emulators.kitty.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}
