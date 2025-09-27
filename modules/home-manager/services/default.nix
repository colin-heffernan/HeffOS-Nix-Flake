{config, ...}: {
  imports = [
    ./mpd
    ./usb-automount.nix
  ];

  xdg = {
    enable = true;
    mime.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_REPOS_DIR = "${config.home.homeDirectory}/Repos";
        XDG_NOTES_DIR = "${config.home.homeDirectory}/Notes";
      };
    };
  };
}
