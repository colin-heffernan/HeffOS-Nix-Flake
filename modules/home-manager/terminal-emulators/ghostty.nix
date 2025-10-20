{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.terminal-emulators.ghostty.enable {
    programs.ghostty = {
      enable = true;
      clearDefaultKeybinds = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        font-family = "IosevkaTerm Nerd Font Mono";
        font-size = 12;
        adjust-cursor-thickness = 1;
        background-opacity = 0.8;
        window-padding-color = "extend";
        resize-overlay = "never";
        auto-update = "off";
        window-decoration = "auto";
        gtk-titlebar = false;
        keybind = [
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+v=paste_from_clipboard"
          "shift+left=adjust_selection:left"
          "shift+down=adjust_selection:down"
          "shift+up=adjust_selection:up"
          "shift+right=adjust_selection:right"
          "ctrl+equal=increase_font_size:1"
          "ctrl+plus=increase_font_size:1"
          "ctrl+minus=decrease_font_size:-1"
          "ctrl+shift+comma=reload_config"
        ];
      };
    };
  };
}
