{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.environments.components.shells.quickshell.enable = lib.mkEnableOption "Quickshell";

  config = lib.mkIf config.heffos.environments.components.shells.quickshell.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
  };
}
