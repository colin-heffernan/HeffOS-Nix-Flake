{
  config,
  lib,
  ...
}: {
  options.heffos.system.printing.enable = lib.mkEnableOption "printing";

  config = lib.mkIf config.heffos.system.printing.enable {
    services.printing.enable = true;
  };
}
