{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.file-nav.enable {
    programs.broot = {
      enable = true;
      settings = {
        imports = [
          {
            luma = "dark";
            file = "skins/catppuccin-mocha.hjson";
          }
          {
            luma = "light";
            file = "skins/catppuccin-mocha.hjson";
          }
        ];
      };
    };
  };
}
