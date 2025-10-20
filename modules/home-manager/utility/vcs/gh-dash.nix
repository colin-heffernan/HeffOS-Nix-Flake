{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.vcs.enable {
    programs.gh-dash.enable = true;
  };
}
