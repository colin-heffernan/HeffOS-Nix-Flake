{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.file-nav.enable {
    programs.broot.enable = true;
  };
}
