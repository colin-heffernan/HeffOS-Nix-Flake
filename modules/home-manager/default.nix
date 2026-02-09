{config, ...}: {
  imports = [
    ./browsers
    ./communication
    ./editors
    ./entertainment
    ./environments
    ./shells
    ./system
    ./terminal-emulators
    ./theme
    ./utility
  ];

  programs.home-manager.enable = true;

  # Many settings taken from the following:
  # https://blog.gitbutler.com/how-git-core-devs-configure-git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Colin Heffernan";
        email = "colinpheffernan@gmail.com";
      };
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        renames = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      commit.verbose = true;
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      pull.ff = "only";
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        REPOS = "${config.home.homeDirectory}/Repos";
        NOTES = "${config.home.homeDirectory}/Notes";
      };
    };
  };
}
