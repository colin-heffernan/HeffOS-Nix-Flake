{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./mpris.nix
    ./rpc.nix
  ];

  config = lib.mkIf osConfig.heffos.services.mpd.enable {
    services.mpd = {
      enable = true;
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }
      '';
    };
  };
}
