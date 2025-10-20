{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.browsers.chromium = {
    enable = lib.mkEnableOption "Chromium";
    ungoogled = lib.mkEnableOption "Ungoogled Chromium";
  };

  config = lib.mkIf config.heffos-home.browsers.chromium.enable {
    programs.chromium = {
      enable = true;
      package = lib.mkIf config.heffos-home.browsers.chromium.ungoogled pkgs.ungoogled-chromium;
    };
  };
}
