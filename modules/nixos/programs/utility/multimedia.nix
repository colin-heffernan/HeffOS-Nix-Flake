{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.multimedia = {
    enable = lib.mkEnableOption "multimedia utilities";
    gimpPlugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "List of GIMP plugins to install.";
      default = [];
    };
    obsPlugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "List of OBS plugins to install.";
      default = [];
    };
  };

  config = lib.mkIf config.heffos.utility.multimedia.enable {
    environment.systemPackages = with pkgs; [
      (gimp-with-plugins.override {
        plugins = config.heffos.utility.multimedia.gimpPlugins;
      })
      inkscape
      (wrapOBS {
        plugins = config.heffos.utility.multimedia.obsPlugins;
      })
      davinci-resolve
      mpv
      tenacity
    ];
  };
}
