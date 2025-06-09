{
  config,
  lib,
  ...
}: {
  /*
  * FIXME: Delete this module
  *
  * I may stop using MPD entirely.
  *
  * I am looking into non-daemon music players
  * and full self-hosted media servers.
  *
  * I am porting some of my MPD configuration
  * over as part of my flake refactoring, but
  * this module will not be imported.
  *
  * MPD was enabled as a system-wide daemon,
  * but configured at the system level for
  * a single user.
  *
  * This is something I was fine with before,
  * but nowadays I consider it bad form.
  */
  options.heffos.services.mpd.enable = lib.mkEnableOption "Music Player Daemon";

  config = lib.mkIf config.heffos.services.mpd.enable {
    services.mpd = {
      enable = true;
      dataDir = ""; # Led to ~/.config/mpd
      musicDirectory = ""; # Led to ~/Music/Music
      playlistDirectory = ""; # Led to ~/Music/Playlists
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }
      ''; # This contained a statefile, stickerfile, and other configuration
      startWhenNeeded = true;
      user = ""; # Was my user, as a fix for PipeWire
    };
    systemd.services.mpd.environment.XDG_RUNTIME_DIR = ""; # Was my user's UID
  };
}
