{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.utility.tty.enable {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        theme = "catppuccin-mocha";
        default_mode = "normal";
        mouse_mode = false;
      };
    };
  };
}
