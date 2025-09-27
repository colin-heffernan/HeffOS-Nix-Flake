{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.environments.compositors.niri.enable {
    xdg.configFile."niri/config.kdl" = {
      source = ./config.kdl;
    };
  };
}
