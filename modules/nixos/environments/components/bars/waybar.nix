{
  config,
  lib,
  ...
}: {
  options.heffos.environments.components.bars.waybar.enable = lib.mkEnableOption "Waybar";

  config = lib.mkIf config.heffos.environments.components.bars.waybar.enable {
    programs.waybar.enable = true;
  };
}
