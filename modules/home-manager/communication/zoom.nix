{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.communication.zoom.enable = lib.mkEnableOption "Zoom";

  config = lib.mkIf config.heffos-home.communication.zoom.enable {
    home.packages = with pkgs; [
      zoom-us
    ];
  };
}
