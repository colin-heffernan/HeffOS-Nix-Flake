{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.multimedia.enable {
    programs.yt-dlp.enable = true;
  };
}
