{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.multimedia.music-production.enable = lib.mkEnableOption "system optimizations for music production";

  config = lib.mkIf config.heffos.utility.multimedia.music-production.enable {
    musnix.enable = true;
  };
}
