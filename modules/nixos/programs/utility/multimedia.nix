{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.multimedia = {
    enable = lib.mkEnableOption "multimedia utilities";
    obsPlugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "List of OBS plugins to install.";
      default = [];
    };
  };

  config = lib.mkIf config.heffos.utility.multimedia.enable {
    environment.systemPackages = with pkgs; [
      gimp
      inkscape
      (wrapOBS {
        plugins = config.heffos.utility.multimedia.obsPlugins;
      })
      mpv
    ];
  };
}
