{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.editors.helix.enable {
    programs.helix = {
      enable = true;
      languages = {
        language-server.rust-analyzer.config.check.command = "clippy";
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "alejandra";
              args = ["--quiet"];
            };
          }
        ];
      };
      settings = {
        theme = "catppuccin_mocha_nobg";
        editor = {
          mouse = false;
          middle-click-paste = false;
          idle-timeout = 300;
          preview-completion-insert = false;
          completion-replace = true;
          bufferline = "never";
          color-modes = true;
          statusline = {
            left = ["mode"];
            center = [];
            right = [];
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };
          lsp.display-messages = true;
          cursor-shape.insert = "bar";
          whitespace.render = "all";
          indent-guides.render = true;
        };
      };
      themes.catppuccin_mocha_nobg = {
        inherits = "catppuccin_mocha";
        "ui.background" = {
          fg = "foreground";
        };
      };
    };
  };
}
