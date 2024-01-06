# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  catppuccin-starship,
  ...
}: let
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Compact-Blue-Dark"
      gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
      gsettings set org.gnome.desktop.interface cursor-theme "Catppuccin-Mocha-Dark-Cursors"
      gsettings set org.gnome.desktop.interface font-name "Liberation Sans 10"
      gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    '';
  };

  update-dbus-env = pkgs.writeTextFile {
    name = "update-dbus-env";
    destination = "/bin/update-dbus-env";
    executable = true;
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
      systemctl --user stop pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland
      systemctl --user start xdg-desktop-portal xdg-desktop-portal-hyprland
      systemctl --user start pipewire pipewire-pulse wireplumber
    '';
  };

  startw = pkgs.writeTextFile {
    name = "startw";
    destination = "/bin/startw";
    executable = true;
    text = ''
      # export WAYLAND_DISPLAY
      # export XDG_CURRENT_DESKTOP=Hyprland
      # export GTK_THEME=Arc-Tokyo-Night
      # export MUSESAMPLER_PATH=/usr/lib/libMuseSamplerCoreLib.so
      # export MUSESAMPLER_INSTRUMENT_FOLDER=/srv/muse-hub/downloads/Instruments/
      # export WINEPREFIX=/home/obsi/.local/share/bottles/bottles/VSTs/
      # export WINELOADER=/home/obsi/.local/share/bottles/runners/soda-7.0-8/bin/wine64
      # export WINEDLLPATH=/home/obsi/.local/share/bottles/runners/soda-7.0-8/lib/wine/x86_64-unix/
      exec Hyprland
    '';
  };
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Add Flake support
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Enable Direnv
  programs.direnv.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel stuff
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;
  boot.initrd.kernelModules = ["amdgpu"];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  # Hostname
  networking.hostName = "heffos"; # Define your hostname.

  /*
     # Wired connectivity
  networking = {
  	networkmanager = {
  		enable = true;
  		logLevel = "DEBUG";
  	};
  	supplicant = {
  		"enp42s0" = {
  			# bridge = "virbr0";
  			driver = "wired";
  			extraCmdArgs = "-u -W -dd";
  			extraConf = ''
  				network={
  					phase1="tls_disable_tlsv1_0=0 tls_disable_tlsv1_1=0 tls_disable_tlsv1_2=0 tls_ext_cert_check=0"
  				}
  			'';
  		};
  	};
  };
  */

  # Wireless connectivity
  networking.wireless = {
    enable = true;
    # userControlled.enable = true;
    environmentFile = "/home/colin/Repos/HeffOS-Nix-Flake/secrets/wireless.env";
    networks = {
      "eduroam" = {
        auth = ''
          eap=PEAP
          phase1="peaplabel=auto tls_disable_tlsv1_0=0 tls_disable_tlsv1_1=0 tls_disable_tlsv1_2=0 tls_ext_cert_check=0"
          phase2="auth=MSCHAPV2"
          identity="@EDUROAM_IDENTITY@"
          password="@EDUROAM_PASSWORD@"
        '';
        authProtocols = ["WPA-EAP"];
      };
      "a12" = {
        psk = "@ATWELVE_PASSWORD@";
      };
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Add udev rules
  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules
    ];
  };

  # Enable D-Bus
  services.dbus = {
    enable = true;
    packages = with pkgs; [
      dconf
    ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Prevent suspend.
  powerManagement.enable = false;
  systemd = {
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  # Enable Manpages
  documentation.man = {
    enable = true;
    man-db = {
      enable = true;
    };
  };

  # Enable Git
  programs.git = {
    enable = true;
  };

  # Enable Polkit.
  security.polkit.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager = {
      awesome = {
        enable = true;
      };
    };
    displayManager = {
      startx = {
        enable = true;
      };
    };
    layout = "us";
    videoDrivers = ["amdgpu"];
  };
  services.picom.enable = true;

  # Enable the Hyprland compositor.
  programs.hyprland = {
    enable = true;
  };

  # Enable Waybar.
  programs.waybar = {
    enable = true;
  };

  # Enable graphics stuff.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # extraPackages = with pkgs; [
    # 	rocm-opencl-icd
    # 	rocm-opencl-runtime
    # ];
    # extraPackages32 = with pkgs.pkgsi686Linux; [
    # 	libva
    # ];
  };

  # Enable virtualization
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            pkgs.OVMFFull.fd
          ];
        };
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # Enable Gnome keyring.
  # services.gnome.gnome-keyring.enable = true;

  # Start the SSH agent on login
  programs.ssh = {
    startAgent = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable PipeWire.
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Enable Wayland screen-sharing.
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Enable Dconf.
  programs.dconf.enable = true;

  # Enable MPD.
  services.mpd = {
    enable = true;
    dataDir = "/home/colin/.config/mpd";
    musicDirectory = "/home/colin/Music/Music";
    playlistDirectory = "/home/colin/Music/Playlists";
    extraConfig = ''
      state_file	"/home/colin/.config/mpd/state"
      sticker_file	"/home/colin/.config/mpd/sticker.sql"

      bind_to_address	"127.0.0.1"
      restore_paused	"yes"
      auto_update	"yes"

      follow_outside_symlinks	"yes"
      follow_inside_symlinks	"yes"

      audio_output {
      	type	"pipewire"
      	name	"PipeWire Sound Server"
      }
    '';
    startWhenNeeded = true;
    user = "colin";
  };
  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  # Enable Zsh.
  programs.zsh = {
    enable = true;
    autosuggestions = {
      enable = true;
      async = true;
    };
    histFile = "$XDG_CONFIG_HOME/zsh/.zsh_history";
    histSize = 10000;
    interactiveShellInit = ''
      lfcd () {
        tmp="$(mktemp)"
        # `command` is needed in case `lfcd` is aliased to `lf`
        command lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
          dir="$(cat "$tmp")"
          rm -f "$tmp"
          if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
              cd "$dir"
            fi
          fi
        fi
      }
    '';
    setOptions = [
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_SPACE"
      "NO_BEEP"
    ];
    shellAliases = {
      ssn = "sudo shutdown now";
      srn = "sudo reboot now";
      lg = "lazygit";
    };
    syntaxHighlighting = {
      enable = true;
    };
    vteIntegration = true;
  };

  # Enable Starship
  programs.starship = {
    enable = true;
    settings =
      {
        add_newline = false;
        format = "$directory$character";
        palette = "catppuccin_mocha";
      }
      // builtins.fromTOML (
        builtins.readFile (
          catppuccin-starship + /palettes/mocha.toml
        )
      );
  };

  # Enable Steam.
  programs.steam.enable = true;

  # Enable Java.
  programs.java.enable = true;

  # Enable Flatpak support.
  # services.flatpak.enable = true;

  # Enable Qt support and make it match GTK2.
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  # Install fonts.
  fonts = {
    packages = with pkgs; [
      emacs-all-the-icons-fonts
      iosevka
      (nerdfonts.override {fonts = ["Iosevka"];})
      liberation_ttf
      lmodern
      noto-fonts
      noto-fonts-extra
      victor-mono
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "full";
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.colin = {
    home = "/home/colin";
    description = "colin";
    isNormalUser = true;
    extraGroups = ["wheel" "storage" "video" "audio" "libvirtd" "kvm" "mpd"];
    shell = pkgs.zsh;
    hashedPasswordFile = "/persist/passwords/colin";
  };

  # List of shells
  environment.shells = with pkgs; [
    bash
    zsh
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # FS utilities
    # mtools
    # dosfstools
    # ntfs3g

    # Compatibility tools
    bottles
    wineWowPackages.waylandFull

    # Virtualization
    virt-manager
    win-virtio

    # WM/DE integration
    lxqt.lxqt-policykit
    mako
    swaybg
    configure-gtk
    update-dbus-env
    startw
    xsettingsd
    slurp
    grim
    tofi

    # Themes
    catppuccin-cursors.mochaDark
    catppuccin-gtk
    papirus-icon-theme

    # CLI programs
    curl
    wget
    glib
    xdotool
    xorg.xwininfo
    git
    yt-dlp
    ffmpeg
    mpc-cli
    # pulseaudio
    # alsa-utils
    zip
    unzip
    p7zip
    # (texlive.combine {
    # 	inherit (texlive) collection-basic
    # 	# collection-binextra collection-langenglish
    # 	chktex
    # 	collection-langenglish
    # 	collection-fontsextra collection-fontsrecommended collection-fontutils
    # 	collection-latex collection-latexextra collection-latexrecommended
    # 	collection-mathscience collection-pictures
    # 	collection-plaingeneric collection-publishers
    # 	collection-xetex;
    # })
    pandoc
    clipboard-jh
    qmk
    bat
    eza
    pistol
    fd
    ripgrep
    file

    # TUI programs
    lazygit
    neofetch
    ncmpcpp
    btop
    helix
    lf
    zellij
    xplr
    weechat

    # GUI programs
    brave
    qpwgraph
    wezterm
    kitty
    easyeffects
    mpv
    famistudio
    obs-studio
    gimp
    cinnamon.warpinator

    # Chat
    cinny-desktop
    discord
    element-desktop
    teamspeak5_client

    # Language servers
    marksman
    nodePackages.bash-language-server
    nil

    # Formatters
    alejandra

    # Just for fun :)
    prismlauncher
    osu-lazer-bin
    freetube
    mpd-discord-rpc
    steamtinkerlaunch
    cava
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    # passwordAuthentication = false;
    # permitRootLogin = "no";
    # ports = [];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [5353 42000 42001];
  networking.firewall.allowedUDPPorts = [5353 42000 42001];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
