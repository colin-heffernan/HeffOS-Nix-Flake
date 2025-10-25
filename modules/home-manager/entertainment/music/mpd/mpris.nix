{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.entertainment.music.mpd.mpris {
    services.mpdris2 = {
      enable = true;
      notifications = true;
    };
  };
}
