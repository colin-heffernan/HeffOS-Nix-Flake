{
  imports = [
    ./browsers
    ./editors
    ./environments
    ./shells
    ./terminal-emulators
    ./utility
  ];

  programs.home-manager.enable = true;

  # Many settings taken from the following:
  # https://blog.gitbutler.com/how-git-core-devs-configure-git
  programs.git = {
    enable = true;
    userName = "Colin Heffernan";
    userEmail = "colinpheffernan@gmail.com";
    extraConfig = {
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
}
