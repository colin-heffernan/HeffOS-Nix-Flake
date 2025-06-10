{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.services.mpd = {
    enable = lib.mkEnableOption "Music Player Daemon";
    rpc = lib.mkEnableOption "RPC support for MPD";
  };

  config = lib.mkIf config.heffos.services.mpd.enable {
    environment.systemPackages = with pkgs; [
      mpc
    ];
  };
}
