{
  config,
  lib,
  ...
}: {
  options.heffos.theme.catppuccin = {
    enable = lib.mkEnableOption "Catppuccin theme";
    cursors.enable = lib.mkEnableOption "Catppuccin cursors";
    gtk = {
      enable = lib.mkEnableOption "Catppuccin for GTK";
      icons = lib.mkEnableOption "Catppuccin for GTK icons";
    };
    kvantum.enable = lib.mkEnableOption "Catppuccin for Kvantum";
  };

  config = lib.mkIf config.heffos.theme.catppuccin.enable {
    catppuccin = {
      enable = true;
      accent = "pink";
      cache.enable = true;
      flavor = "mocha";
    };
  };
}
