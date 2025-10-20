{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.environments.components.runners.fuzzel.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Iosevka Aile:size=12";
          use-bold = true;
        };
      };
    };
  };
}
