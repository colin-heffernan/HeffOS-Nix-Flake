{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.browsers.librewolf.enable = lib.mkEnableOption "LibreWolf";

  config = lib.mkIf config.heffos.browsers.librewolf.enable {
    environment.systemPackages = with pkgs; [
      librewolf
    ];
  };
}
