{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.vcs.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
