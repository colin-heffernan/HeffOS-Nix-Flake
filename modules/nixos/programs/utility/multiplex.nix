{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.multiplex.enable = lib.mkEnableOption "terminal multiplexers";

  config = lib.mkIf config.heffos.utility.multiplex.enable {
    environment.systemPackages = with pkgs; [
      zellij
    ];
  };
}
