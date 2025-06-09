{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.communication.mumble.enable = lib.mkEnableOption "Mumble";

  config = lib.mkIf config.heffos.communication.mumble.enable {
    environment.systemPackages = with pkgs; [
      mumble
    ];
  };
}
