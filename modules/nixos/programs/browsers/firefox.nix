{
  config,
  lib,
  ...
}: {
  options.heffos.browsers.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf config.heffos.browsers.firefox.enable {
    programs.firefox.enable = true;
  };
}
