{
  config,
  lib,
  ...
}: {
  options.heffos.theme.catppuccin.enable = lib.mkEnableOption "Catppuccin theme";

  config = lib.mkIf config.heffos.theme.catppuccin.enable {
    catppuccin = {
      enable = true;
      accent = "pink";
      cache.enable = true;
      flavor = "mocha";
    };
  };
}
