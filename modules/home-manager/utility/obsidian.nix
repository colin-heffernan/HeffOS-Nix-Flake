{
  config,
  lib,
  ...
}: {
  options.heffos-home.utility.obsidian.enable = lib.mkEnableOption "Obsidian";

  config = lib.mkIf config.heffos-home.utility.obsidian.enable {
    programs.obsidian.enable = true;
  };
}
