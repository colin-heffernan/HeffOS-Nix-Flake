{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.modern-alts.enable {
    programs.eza.enable = true;
  };
}
