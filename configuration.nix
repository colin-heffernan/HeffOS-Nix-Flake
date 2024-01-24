# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-dev,
  ...
}: {
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
  # services.xserver = {
  #   enable = true;
  #   windowManager = {
  #     awesome = {
  #       enable = true;
  #     };
  #   };
  #   displayManager = {
  #     startx = {
  #       enable = true;
  #     };
  #   };
  #   layout = "us";
  #   videoDrivers = ["amdgpu"];
  # };
  # services.picom.enable = true;

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

  # Enable Fish
  programs.fish = {
    enable = true;
    shellAbbrs = {
      startw = "exec Hyprland";
      ssn = "sudo shutdown now";
      srn = "sudo reboot now";
      sup = "sudo nixos-rebuild switch --flake ~/Repos/HeffOS-Nix-Flake#heffos";
      lg = "lazygit";
      fm = "cd \"$(command lf -print-last-dir $argv)\"";
    };
  };

  # Enable Starship
  programs.starship.enable = true;

  # Enable Neovim
  programs.neovim = {
    enable = true;
    configure.packages.myVimPackage = with pkgs.vimPlugins; {
      start = [
        mini-nvim
      ];
      opt = [
        lsp-zero-nvim
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
      ];
    };
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
      iosevka
      (nerdfonts.override {fonts = ["Iosevka"];})
      liberation_ttf
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
    shell = pkgs.fish;
    hashedPasswordFile = "/persist/passwords/colin";
  };

  # List of shells
  environment.shells = with pkgs; [
    bash
    zsh
    fish
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
    xsettingsd
    slurp
    grim
    tofi

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
    wl-clipboard
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
    joshuto
    weechat

    # GUI programs
    brave
    qpwgraph
    wezterm
    kitty
    easyeffects
    mpv
    famistudio
    (wrapOBS
      {
        plugins = with pkgs.obs-studio-plugins; [
          obs-livesplit-one
        ];
      })
    gimp
    reaper
    cinnamon.warpinator
    libsForQt5.kdenlive

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
