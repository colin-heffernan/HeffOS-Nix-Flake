{
  config,
  pkgs,
  catppuccin-bat,
  catppuccin-btop,
  catppuccin-starship,
  ...
} @ inputs: {
  # Tell Home-Manager what home to manage
  home.username = "obsi";
  home.homeDirectory = "/home/obsi";

  # State version
  home.stateVersion = "22.11";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Awesome config
  home.file.".config/awesome" = {
    source = ./dotfiles/.config/awesome;
    recursive = true;
  };

  # Bat config
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin-mocha";
    };
    themes = {
      Catppuccin-mocha = builtins.readFile (catppuccin-bat + "/Catppuccin-mocha.tmTheme");
    };
  };

  # Btop config
  home.file.".config/btop/themes" = {
    source = catppuccin-btop + "/themes";
    recursive = true;
  };
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha";
      theme_background = false;
    };
  };

  # Direnv config
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  # EWW config
  home.file.".config/eww" = {
    source = ./dotfiles/.config/eww;
    recursive = true;
  };

  # Exa config
  programs.exa = {
    enable = true;
    extraOptions = [
      "-la"
      "--group-directories-first"
    ];
    icons = true;
  };

  # Git config
  programs.git = {
    enable = true;
    userName = "Colin Heffernan";
    userEmail = "colinpheffernan@gmail.com";
  };

  # GTK
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
    };
    font = {
      name = "Liberation Sans";
      size = 10;
    };
    iconTheme = {
      name = "Papirus";
    };
    theme = {
      name = "Catppuccin-Mocha-Compact-Blue-Dark";
    };
  };

  # Helix config
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server.rust-analyzer = {
        config = {
          check.command = "clippy";
        };
      };
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
        completion-replace = true;
        true-color = true;
        undercurl = true;
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
        lsp = {
          display-messages = true;
        };
        cursor-shape = {
          insert = "bar";
        };
        file-picker = {
          hidden = false;
          max-depth = 5;
        };
        auto-pairs = {
          "(" = ")";
          "{" = "}";
          "[" = "]";
          "'" = "'";
          "\"" = "\"";
          "`" = "`";
          "<" = ">";
        };
        whitespace = {
          render = "all";
        };
        indent-guides = {
          render = true;
        };
      };
    };
    themes = {
      catppuccin_mocha_nobg = {
        inherits = "catppuccin_mocha";
        "ui.background" = {
          fg = "foreground";
        };
      };
    };
  };

  # Hyprland config
  home.file.".config/hypr" = {
    source = ./dotfiles/.config/hypr;
    recursive = true;
  };

  # LF config
  home.file.".config/lf" = {
    source = ./dotfiles/.config/lf;
    recursive = true;
  };

  # NCMPCPP config
  programs.ncmpcpp = {
    enable = true;
    settings = {
      external_editor = "nvim";
      autocenter_mode = "yes";
      centered_cursor = "yes";
      ignore_leading_the = "yes";
      allow_for_physical_item_deletion = "no";
      follow_now_playing_lyrics = "yes";
      startup_screen = "playlist";
      browser_sort_mode = "name";
      browser_playlist_prefix = "[Playlist]";
      progressbar_look = "───";
      progressbar_color = "black";
      progressbar_elapsed_color = "blue";
      song_list_format = "{%a - }{%t}$R{%l}";
      current_item_prefix = "$(blue)$r";
      song_columns_list_format = "(20)[]{a} (50)[]{t} (7f)[]{l}";
      statusbar_visibility = "no";
      colors_enabled = "yes";
      empty_tag_color = "blue";
      header_window_color = "blue";
      volume_color = "blue";
      state_line_color = "blue";
      state_flags_color = "blue";
      main_window_color = "blue";
      color1 = "blue";
      color2 = "blue";
      statusbar_color = "blue";
      player_state_color = "blue";
      window_border_color = "blue";
      active_window_border = "blue";
    };
  };

  # Pistol config
  programs.pistol = {
    enable = true;
    associations = [
      {
        mime = "text/*";
        command = "bat --paging=never --color=always -p %pistol-filename%";
      }
    ];
  };

  # Rofi config
  home.file.".config/rofi" = {
    source = ./dotfiles/.config/rofi;
    recursive = true;
  };

  # Starship config
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings =
      {
        add_newline = false;
        format = "$directory$character";
        palette = "catppuccin_mocha";
      }
      // builtins.fromTOML (
        builtins.readFile
        (catppuccin-starship
          + /palettes/mocha.toml)
      );
  };

  # Wezterm config
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require "wezterm"

      function recompute_stretch(window, pane)
      	local window_dims = window:get_dimensions()
      	local overrides = window:get_config_overrides() or {}
      	local window_conf = window:effective_config() or {}
      	local tab_dims = pane:tab():get_size()

      	left_pad = math.floor((window_dims.pixel_width - tab_dims.pixel_width) / 2)
      	top_pad = math.floor((window_dims.pixel_height - tab_dims.pixel_height) / 2)
      	if
      		overrides.window_padding
      		and overrides.window_padding.left == left_pad
      		and overrides.window_padding.top == top_pad
      	then
      		return
      	end
      	overrides.window_padding = {
      		left = left_pad,
      		right = 0,
      		top = top_pad,
      		bottom = 0
      	}

      	window:set_config_overrides(overrides)
      end

      wezterm.on("window-resized", function(window, pane)
      	recompute_stretch(window, pane)
      end)

      wezterm.on("window-config-reloaded", function(window, pane)
      	recompute_stretch(window, pane)
      end)

      local config = {
      	adjust_window_size_when_changing_font_size = false,
      	allow_square_glyphs_to_overflow_width = "Never",
      	audible_bell = "Disabled",
      	color_scheme = "Catppuccin Mocha",
      	default_cursor_style = "SteadyBar",
      	font = wezterm.font "Iosevka",
      	font_size = 12.0,
      	hide_tab_bar_if_only_one_tab = true,
      	window_background_opacity = 0.8,
      	--[[ window_padding = { ]]
      	--[[ 	left = 0, ]]
      	--[[ 	right = 0, ]]
      	--[[ 	top = 0, ]]
      	--[[ 	bottom = 0 ]]
      	--[[ } ]]
      }

      return config
    '';
  };

  # .xinitrc
  home.file.".xinitrc" = {
    source = ./dotfiles/.xinitrc;
  };

  # Zsh config
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    dotDir = ".config/zsh";
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      save = 10000;
      share = true;
      size = 10000;
    };
    initExtra = ''
      unsetopt beep
    '';
    localVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
    shellAliases = {
      ssn = "sudo shutdown now";
      srn = "sudo reboot now";
      lg = "lazygit";
    };
  };
}
