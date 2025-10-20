{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.entertainment.mpd.rpc {
    services.mpd-discord-rpc = {
      enable = true;
      settings = {
        format = {
          details = "$artist - $title";
          state = "On $album";
          large_image = "";
          small_image = "";
        };
      };
    };
  };
}
