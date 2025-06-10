{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkMerge [
    (lib.mkIf osConfig.heffos.services.mpd.enable {
      services.mpd = {
        enable = true;
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "PipeWire Sound Server"
          }
        '';
      };
    })
    (lib.mkIf osConfig.heffos.services.mpd.rpc {
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
    })
  ];
}
