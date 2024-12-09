{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.terminal-emulators.wezterm.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = builtins.readFile ./init.lua;
    };
  };
}
