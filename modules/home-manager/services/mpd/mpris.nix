{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.services.mpd.mpris {
    services.mpdris2 = {
      enable = true;
      notifications = true;
    };
  };
}
