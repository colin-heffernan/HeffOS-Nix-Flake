{
  config,
  lib,
  ...
}: {
  options.heffos-home.terminal-emulators.kitty.enable = lib.mkEnableOption "Kitty";

  config = lib.mkIf config.heffos-home.terminal-emulators.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "IosevkaTermNerdFont";
        size = 12.0;
      };
      keybindings = {
        "ctrl+shift+c" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";
      };
      settings = {
        clear_all_shortcuts = "yes";
        cursor_shape = "beam";
        enable_audio_bell = false;
        background_opacity = "0.8";
        enabled_layouts = "splits";
      };
      shellIntegration = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
