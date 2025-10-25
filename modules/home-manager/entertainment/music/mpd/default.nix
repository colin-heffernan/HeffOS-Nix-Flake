{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./mpris.nix
    ./rpc.nix
  ];

  options.heffos-home.entertainment.music.mpd = {
    enable = lib.mkEnableOption "Music Player Daemon";
    mpris = lib.mkEnableOption "MPRIS support for MPD";
    rpc = lib.mkEnableOption "Discord RPC support for MPD";
  };

  config = lib.mkIf config.heffos-home.entertainment.music.mpd.enable {
    home.packages = with pkgs; [
      mpc
    ];

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
