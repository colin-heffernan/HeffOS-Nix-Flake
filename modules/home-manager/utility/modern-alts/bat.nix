{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.modern-alts.enable {
    programs.bat.enable = true;
  };
}
