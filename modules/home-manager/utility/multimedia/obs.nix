{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.multimedia.enable {
    programs.obs-studio.enable = true;
  };
}
