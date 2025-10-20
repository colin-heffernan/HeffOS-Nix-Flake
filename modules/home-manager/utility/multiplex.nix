{
  config,
  lib,
  ...
}: {
  options.heffos-home.utility.multiplex.enable = lib.mkEnableOption "terminal multiplexers";

  config = lib.mkIf config.heffos-home.utility.multiplex.enable {
    programs.zellij.enable = true;
  };
}
