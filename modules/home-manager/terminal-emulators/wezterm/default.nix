{
  config,
  lib,
  ...
}: {
  options.heffos-home.terminal-emulators.wezterm.enable = lib.mkEnableOption "WezTerm";

  config = lib.mkIf config.heffos-home.terminal-emulators.wezterm.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./init.lua;
    };
  };
}
