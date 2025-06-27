{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.notes.enable = lib.mkEnableOption "a notes app";

  config = lib.mkIf config.heffos.utility.notes.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
