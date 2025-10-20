{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.fuzzy.enable {
    programs.fzf.enable = true;
  };
}
