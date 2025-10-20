{
  config,
  lib,
  ...
}: {
  options.heffos.system.polkit.enable = lib.mkEnableOption "Polkit";

  config = lib.mkIf config.heffos.system.polkit.enable {
    security.polkit.enable = true;
  };
}
