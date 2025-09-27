{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.nh.enable = lib.mkEnableOption "NH, a Nix helper";
  
  config = lib.mkIf config.heffos.utility.nh.enable {
    programs.nh.enable = true;
  };
}
