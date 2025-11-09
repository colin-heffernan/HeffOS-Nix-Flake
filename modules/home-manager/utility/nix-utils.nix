{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: {
  options.heffos-home.utility.nix-utils.enable = lib.mkEnableOption "utilities for Nix";

  config = lib.mkIf config.heffos-home.utility.nix-utils.enable {
    programs.nh = {
      enable = true;
      flake = osConfig.heffos.config-dir;
    };

    home.packages = with pkgs; [
      manix
    ];
  };
}
