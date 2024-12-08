{
  config,
  lib,
  ...
}: {
  options.heffos.services.polkit.enable = lib.mkEnableOption "Polkit";

  config = lib.mkIf config.heffos.services.polkit.enable {
    security.polkit.enable = true;
  };
}
