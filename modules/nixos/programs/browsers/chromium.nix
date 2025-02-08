{
  config,
  lib,
  ...
}: {
  options.heffos.browsers.chromium.enable = lib.mkEnableOption "Chromium";

  config = lib.mkIf config.heffos.browsers.chromium.enable {
    programs.chromium.enable = true;
    # TODO: Declaratively configure the browser?
  };
}
