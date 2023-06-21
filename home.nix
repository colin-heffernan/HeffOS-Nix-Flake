{
  config,
  pkgs,
  ...
}: {
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
      size = "10";
    };
    iconTheme = {
      name = "Papirus";
    };
    theme = {
      name = "Catppuccin-Mocha-Compact-Blue";
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

  # Kitty config
  # programs.kitty = {
  # 	enable = true;
  # 	font = {
  # 		name = "Iosevka";
  # 		size = 12.0;
  # 	};
  # 	settings = {
  # 		cursor_shape = "beam";
  # 		enable_audio_bell = false;
  # 		background_opacity = "0.8";
  # 	};
  # 	theme = "Tokyo Night";
  # };

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

  # Neofetch config
  home.file.".config/neofetch" = {
    source = ./dotfiles/.config/neofetch;
    recursive = true;
  };

  # Nushell config
  # home.file.".config/nushell" = {
  # 	source = ./dotfiles/.config/nushell;
  # 	recursive = true;
  # };

  # Pistol config
  home.file.".config/pistol" = {
    source = ./dotfiles/.config/pistol;
    recursive = true;
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
  home.file.".zshrc" = {
    source = ./dotfiles/.zshrc;
  };
  home.file.".p10k.zsh" = {
    source = ./dotfiles/.p10k.zsh;
  };
}
