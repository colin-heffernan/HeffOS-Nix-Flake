{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.vcs.enable = lib.mkEnableOption "utilities for version control systems";

  config = lib.mkIf config.heffos.utility.vcs.enable {
    environment.systemPackages = with pkgs; [
      lazygit
      gh
      gh-dash
    ];
  };
}
