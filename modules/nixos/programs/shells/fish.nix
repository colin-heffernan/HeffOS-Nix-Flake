{
  config,
  lib,
  ...
}: {
  options.heffos.shells.fish.enable = lib.mkEnableOption "Fish Shell";

  config = lib.mkIf config.heffos.shells.fish.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = config.heffos.shells.aliases;
    };
  };
}
