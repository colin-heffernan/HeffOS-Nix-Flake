{
  config,
  pkgs,
  lib,
  catppuccin-bat,
  catppuccin-btop,
  catppuccin-starship,
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
  # home.file.".config/awesome" = {
  #   source = ./dotfiles/.config/awesome;
  #   recursive = true;
  # };

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
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 144;
        bar_width = 3;
        bar_spacing = 1;
        sensitivity = 72;
      };
      input = {
        method = "pipewire";
        source = "alsa:pcm:1";
        # method = "fifo";
        # source = "/tmp/mpd.fifo";
      };
      color = {
        gradient = 1;
        gradient_count = 6;
        gradient_color_1 = "'#b4befe'";
        gradient_color_2 = "'#89b4fa'";
        gradient_color_3 = "'#a6e3a1'";
        gradient_color_4 = "'#f9e2af'";
        gradient_color_5 = "'#fab387'";
        gradient_color_6 = "'#f38ba8'";
      };
    };
  };

  # Direnv config
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  # EasyEffects config
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

  # Firefox config
  # TODO
  # programs.firefox = {
  #   enable = true;
  #   profiles."colin" = {
  #     extensions = [];
  #     name = "Colin";
  #     search.default = "DuckDuckGo";
  #   };
  # };
  # TODO

  # Fish config
  programs.fish = {
    enable = true;
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
    font = {
      name = "Liberation Sans";
      package = pkgs.liberation_ttf;
      size = 10;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Catppuccin-Mocha-Compact-Blue-Dark";
      package = pkgs.catppuccin-gtk;
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
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
        lsp = {
          display-messages = true;
        };
        cursor-shape = {
          insert = "bar";
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
  home.file."Pictures/bg.png" = {
    source = ./dotfiles/.config/hypr/nixhex.png;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "DP-3,highrr,auto,1";
      workspace = "DP-3,1";
      general = {
        border_size = 2;
        gaps_in = 5;
        gaps_out = 5;
        "col.active_border" = "rgba(89b4faff) rgba(89dcebff) 30deg";
        "col.inactive_border" = "rgba(11111bff) rgba(181825ff) 30deg";
        layout = "dwindle";
        no_cursor_warps = true;
        no_focus_fallback = true;
        hover_icon_on_border = false;
      };
      decoration = {
        rounding = 5;
        drop_shadow = false;
        dim_inactive = false;
        blur = {
          size = 3;
          passes = 3;
          noise = 0.2;
          contrast = 0.25;
          brightness = 0.25;
          vibrancy = 0.25;
          vibrancy_darkness = 0.12;
        };
      };
      animations = {
        bezier = "easeOut, 0.16, 1.00, 0.32, 1.00";
        animation = [
          "windows, 1, 6, easeOut, popin"
          "windowsOut, 1, 6, easeOut, popin 80%"
          "border, 1, 6, easeOut,"
          "fade, 1, 6, easeOut,"
          "workspaces, 1, 6, easeOut, slidevert"
        ];
      };
      dwindle = {
        force_split = 2;
      };
      group = {
        insert_after_current = false;
      };
      exec-once = [
        # "easyeffects --gapplication-service &"
        "xsettingsd &"
        "swaybg -i ~/Pictures/bg.png -m fill &"
        "lxqt-policykit-agent &"
      ];
      "$mainMod" = "SUPER";
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bind =
        [
          "$mainMod, T, exec, kitty"
          "$mainMod SHIFT, T, exec, wezterm"
          "$mainMod, B, exec, brave"
          "$mainMod SHIFT, B, exec, brave --incognito"
          "$mainMod, P, exec, tofi-drun"
          "$mainMod, C, killactive,"
          "$mainMod, Q, exec, hyprctl reload"
          "$mainMod SHIFT, Q, exit,"
          "$mainMod, F, fullscreen,"
          "$mainMod SHIFT, F, togglefloating"
          "$mainMod, S, exec, grim -g \"$(slurp)\" - | wl-copy"
          "$mainMod SHIFT, S, exec, grim -t jpeg -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).jpg"
          "$mainMod SHIFT, N, exec, mpc prev"
          "$mainMod SHIFT, E, exec, mpc toggle"
          "$mainMod SHIFT, I, exec, mpc next"
          "$mainMod SHIFT, U, exec, mpc volume +36"
          "$mainMod SHIFT, comma, exec, mpc volume -36"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            9)
        );
    };
    systemd = {
      enable = true;
      variables = [
        "DISPLAY"
        "HYPRLAND_INSTANCE_SIGNATURE"
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP"
      ];
    };
  };

  # Kitty config
  programs.kitty = {
    enable = true;
    font = {
      name = "IosevkaNerdFont";
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
    theme = "Catppuccin-Mocha";
  };

  # LF config
  # FIXME
  home.file.".config/lf" = {
    source = ./dotfiles/.config/lf;
    recursive = true;
  };
  # FIXME

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

  # Neovim config
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    extraLuaConfig = ''
      -- Someday, someday...
    '';
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

  # QT config
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  # Starship config
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings =
      {
        add_newline = false;
        format = lib.concatStrings [
          "$line_break"
          "$nix_shell"
          "$line_break"
          "$directory"
          "$character"
        ];
        nix_shell = {
          format = "In [$state]($style)[Nix Shell.]($style)";
          impure_msg = "impure ";
          pure_msg = "pure ";
          unknown_msg = "";
        };
        palette = "catppuccin_mocha";
      }
      // builtins.fromTOML (
        builtins.readFile (
          catppuccin-starship + /palettes/mocha.toml
        )
      );
  };

  # Tofi config
  # FIXME
  home.file.".config/tofi" = {
    source = ./dotfiles/.config/tofi;
    recursive = true;
  };
  # FIXME

  # Waybar config
  # TODO
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
      # vis = {
      #   layer = "bottom";
      #   position = "left";
      #   exclusive = false;
      #   modules-center = [
      #     "cava"
      #   ];
      #   "cava" = {
      #     framerate = 144;
      #     bars = 176;
      #     method = "fifo";
      #     source = "/tmp/mpd.fifo";
      #     bar_delimiter = 0;
      #     format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      #     rotate = 270;
      #   };
      # };
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
      #cava {
        color: #1e1e2e;
        margin-left: 10px;
      }
    '';
  };
  # TODO

  # Wezterm config
  # TODO
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
  # TODO

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
}
