{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.multimedia.enable {
    programs.mpv = {
      enable = true;
      config = {
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
      };
    };
  };
}
