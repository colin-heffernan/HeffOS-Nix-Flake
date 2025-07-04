{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.theme.catppuccin.enable {
    catppuccin = {
      enable = true;
      accent = "pink";
      cache.enable = true;
      # cursors.enable = true;
      flavor = "mocha";
      gtk = {
        # enable = true;
        icons.enable = false;
        size = "compact";
      };
    };
  };
}
