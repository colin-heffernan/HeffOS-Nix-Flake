{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.utility.vcs.enable {
    programs.git.delta.enable = true;
  };
}
