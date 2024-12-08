{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.terminal-emulators.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "IosevkaNerdFont"; # TODO: May need to be fixed.
        size = 12.0;
      };
      keybindings = {
        "ctrl+shift+c" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";
        "alt+t" = "launch --cwd=current --location=split";
        "alt+c" = "close_window";
        "alt+left" = "neighboring_window left";
        "alt+down" = "neighboring_window down";
        "alt+up" = "neighboring_window up";
        "alt+right" = "neighboring_window right";
      };
      settings = {
        clear_all_shortcuts = "yes";
        cursor_shape = "beam";
        enable_audio_bell = false;
        background_opacity = "0.8";
        enabled_layouts = "splits";
      };
      themeFile = "Catppuccin-Mocha";
    };
  };
}