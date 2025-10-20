{
  config,
  lib,
  osConfig,
  ...
}: {
  options.heffos-home.utility.nh.enable = lib.mkEnableOption "NH, a Nix helper";

  config = lib.mkIf config.heffos-home.utility.nh.enable {
    programs.nh = {
      enable = true;
      flake = osConfig.heffos.config-dir;
    };
  };
}
