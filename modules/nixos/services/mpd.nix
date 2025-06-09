{lib, ...}: {
  options.heffos.services.mpd.enable = lib.mkEnableOption "Music Player Daemon";
}
