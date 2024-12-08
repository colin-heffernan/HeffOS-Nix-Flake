{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.browsers.brave.enable = lib.mkEnableOption "Brave";

  config = lib.mkIf config.heffos.browsers.brave.enable {
    environment.systemPackages = with pkgs; [
      brave
    ];
  };
}
