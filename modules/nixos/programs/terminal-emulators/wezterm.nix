{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.terminal-emulators.wezterm.enable = lib.mkEnableOption "WezTerm";

  config = lib.mkIf config.heffos.terminal-emulators.wezterm.enable {
    environment.systemPackages = with pkgs; [
      wezterm
    ];
  };
}
