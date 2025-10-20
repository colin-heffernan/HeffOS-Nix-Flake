{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.multimedia.enable {
    programs.beets.enable = true;
  };
}
