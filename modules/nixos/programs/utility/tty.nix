{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.tty.enable = lib.mkEnableOption "TTY-friendly utilities";

  config = lib.mkIf config.heffos.utility.tty.enable {
    environment.systemPackages = with pkgs; [
      ripgrep
      fd
      zellij
      ffmpeg
      yt-dlp
      android-file-transfer
      pandoc
    ];
  };
}
