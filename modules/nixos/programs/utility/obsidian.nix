{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.obsidian.enable = lib.mkEnableOption "Obsidian";

  config = lib.mkIf config.heffos.utility.obsidian.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
