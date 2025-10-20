{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.file-nav.enable {
    programs.zoxide.enable = true;
  };
}
