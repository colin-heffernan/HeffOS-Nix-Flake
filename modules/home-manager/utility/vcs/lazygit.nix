{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.vcs.enable {
    programs.lazygit.enable = true;
  };
}
