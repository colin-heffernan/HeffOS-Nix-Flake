{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.browsers.brave.enable = lib.mkEnableOption "Brave";

  config = lib.mkIf config.heffos-home.browsers.brave.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}
