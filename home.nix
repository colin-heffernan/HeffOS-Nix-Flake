{
  config,
  pkgs,
  catppuccin-bat,
  catppuccin-btop,
  ...
}: {
  # Tell Home-Manager what home to manage
  home.username = "colin";
  home.homeDirectory = "/home/colin";

  # State version
  home.stateVersion = "23.11";

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
      Catppuccin-mocha = {
        src = catppuccin-bat;
        file = "Catppuccin-mocha.tmTheme";
      };
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

  # CAVA config
  home.file.".config/cava" = {
    source = ./dotfiles/.config/cava;
    recursive = true;
  };

  # Direnv config
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  # EasyEffects
  services.easyeffects = {
    enable = true;
  };

  # Eza config
  programs.eza = {
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

  # Mako config
  services.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#1e1e2e";
    borderColor = "#89b4fa";
    borderRadius = 5;
    borderSize = 2;
    defaultTimeout = 15000;
    font = "Iosevka 10";
    layer = "top";
    progressColor = "#313244";
    textColor = "#cdd6f4";
  };

  # MPD Discord RPC config
  services.mpd-discord-rpc = {
    enable = true;
    settings = {
      format = {
        details = "$title";
        state = "On $album by $artist";
      };
      hosts = [
        "127.0.0.1:6600"
      ];
    };
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

  # Tofi config
  home.file.".config/tofi" = {
    source = ./dotfiles/.config/tofi;
    recursive = true;
  };

  # Waybar config
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        layer = "top";
        position = "left";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "clock"
        ];
        "hyprland/workspaces" = {
          format = "{name}";
        };
        "clock" = {
          interval = 1;
          format = "{:%H%n%M}";
          format-alt = "{:%m%n%d}";
        };
      };
    };
    style = ''
      * {
        background: transparent;
        border: none;
        border-radius: 0;
        font-family: Iosevka;
        font-size: 16px;
        min-height: 0;
      }
      #workspaces, #clock {
        margin: 5px;
        min-width: 32px;
        padding: 6px;
        background: #1e1e2e;
        border-radius: 10px;
        color: #cdd6f4;
      }
      #workspaces button {
        background: transparent;
        border: none;
        border-radius: 5px;
        color: #cdd6f4;
      }
      #workspaces button.active {
        background: #89b4fa;
        border: none;
        border-radius: 5px;
        color: #1e1e2e;
      }
      #workspaces button:hover {
        background: transparent;
        border: none;
        border-radius: 5px;
        color: #cdd6f4;
        box-shadow: inherit;
        text-shadow: inherit;
      }
      #workspaces button.active:hover {
        background: #89b4fa;
        border: none;
        border-radius: 5px;
        color: #1e1e2e;
        box-shadow: inherit;
        text-shadow: inherit;
      }
    '';
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
        enable_kitty_graphics = true,
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

  # XDG config
  xdg = {
    enable = true;
    mime = {
      enable = true;
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_REPOS_DIR = "${config.home.homeDirectory}/Repos";
        XDG_NOTES_DIR = "${config.home.homeDirectory}/Notes";
      };
    };
  };

  # .xinitrc
  home.file.".xinitrc" = {
    source = ./dotfiles/.xinitrc;
  };

  # Zsh config
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    localVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
  };
}
