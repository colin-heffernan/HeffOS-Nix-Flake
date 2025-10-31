{pkgs, ...}: {
  imports = [
    ./mpd
    ./spotify.nix
  ];

  home.packages = with pkgs; [
    playerctl
  ];
}
