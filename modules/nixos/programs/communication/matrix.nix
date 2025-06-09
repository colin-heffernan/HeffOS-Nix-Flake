{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.communication.matrix.enable = lib.mkEnableOption "a Matrix client";

  config = lib.mkIf config.heffos.communication.matrix.enable {
    environment.systemPackages = with pkgs; [
      element-desktop
    ];
  };
}
