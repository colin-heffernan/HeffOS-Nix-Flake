{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.browsers.vivaldi.enable = lib.mkEnableOption "Vivaldi";

  config = lib.mkIf config.heffos.browsers.vivaldi.enable {
    environment.systemPackages = with pkgs; [
      vivaldi
    ];
  };
}
