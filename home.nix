{
  config,
  pkgs,
  catppuccin-bat,
  catppuccin-btop,
  catppuccin-starship,
  catppuccin-prism,
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
  home.file.".config/helix" = {
    source = ./dotfiles/.config/helix;
    recursive = true;
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
  home.file.".config/wezterm" = {
    source = ./dotfiles/.config/wezterm;
    recursive = true;
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
