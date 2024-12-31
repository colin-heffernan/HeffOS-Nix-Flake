{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.terminal-emulators.ghostty.enable = lib.mkEnableOption "Ghostty";

  config = lib.mkIf config.heffos.terminal-emulators.ghostty.enable {
    environment.systemPackages = with pkgs; [
      ghostty
    ];
  };
}
