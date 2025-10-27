{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./beets.nix
    ./imv.nix
    ./mpv.nix
    ./yt-dlp.nix
  ];

  options.heffos-home.utility.multimedia.enable = lib.mkEnableOption "multimedia utilities";

  config = lib.mkIf config.heffos-home.utility.multimedia.enable {
    home.packages = with pkgs; [
      gimp
      inkscape
      audacity
      # reaper
      davinci-resolve
      ffmpeg_8
      imagemagick
      flac
    ];
  };
}
