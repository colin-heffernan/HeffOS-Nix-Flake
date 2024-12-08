{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.freetube.enable = lib.mkEnableOption "FreeTube";

  config = lib.mkIf config.heffos.entertainment.freetube.enable {
    environment.systemPackages = with pkgs; [
      freetube
    ];
  };
}
