{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ../../modules/nixos
  ];

  # Manage secrets
  sops = {
    defaultSopsFile = ../../secrets/hitori.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = let
      isEd25519 = k: k.type == "ed25519";
      getKeyPath = k: k.path;
      keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
    in
      map getKeyPath keys;
    secrets = {
      hashedPassword.neededForUsers = true;
      "wireless.conf" = {
        sopsFile = ../../secrets/shared.yaml;
        format = "yaml";
      };
      tailscale_key = {
        sopsFile = ../../secrets/shared.yaml;
        format = "yaml";
      };
    };
  };

  # Set the PC hostname
  networking.hostName = "heffos-hitori";

  # Configure the time
  time = {
    timeZone = "America/New_York";
    hardwareClockInLocalTime = true;
  };

  # Configure the firewall
  networking.firewall = {
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # Soft-disable SSH
  services.openssh = {
    enable = true;
    hostKeys = [
      {
        path = "/persist/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
    ports = []; # Prevent any ports from reaching OpenSSH
    settings = {
      PasswordAuthentication = false; # Prevent logging in via password (only SSH keys work)
      PermitRootLogin = "no"; # Prevent root login entirely
    };
  };

  # Use the HeffOS module system
  heffos = {
    config-dir = "/home/colin/heffos";
    theme.catppuccin.enable = true;
    compat = {
      translation.enable = true;
      virtualization.enable = true;
    };
    entertainment = {
      games = {
        gamemode.enable = true;
        steam.enable = true;
        vr = {
          enable = true;
          wireless = true;
        };
      };
    };
    environments = {
      components = {
        bars.waybar.enable = true;
        notifications.mako.enable = true;
        runners.fuzzel.enable = true;
        wallpapers.swaybg.enable = true;
      };
      compositors.niri.enable = true;
      # desktop-environments.plasma.enable = true;
      display-managers.sddm.enable = true;
    };
    system = {
      bootloader = {
        enable = true;
        dualboot.enable = true;
      };
      connectivity = {
        wifi-networks = {
          a12.enable = true;
          whitesky.enable = true;
        };
        bluetooth.enable = true;
        tailscale.enable = true;
      };
      fonts.enable = true;
      hardware-acceleration.enable = true;
      nix-gc.enable = true;
      pipewire.enable = true;
      polkit.enable = true;
      # printing.enable = true;
      usb-automount.enable = true;
      zram.enable = true;
    };
    utility = {
      obs = {
        enable = true;
      };
    };
  };

  # Configure system users
  users = {
    mutableUsers = false;
    users.colin = {
      description = "Colin Heffernan";
      isNormalUser = true;
      extraGroups = [
        "gamemode"
        "libvirtd"
        "wheel"
      ];
      hashedPasswordFile = config.sops.secrets.hashedPassword.path;
    };
  };

  # Configure Home Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    users.colin = {
      inputs,
      pkgs,
      osConfig,
      ...
    }: {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.spicetify-nix.homeManagerModules.spicetify
        ../../modules/home-manager
      ];

      home = {
        # Tell Home Manager which home to manage
        homeDirectory = osConfig.users.users.colin.home;
        username = osConfig.users.users.colin.name;

        # Set the Home Manager version from
        # which all default values are taken
        stateVersion = "23.11";
      };

      heffos-home = {
        browsers = {
          brave.enable = true;
          chromium = {
            enable = true;
            ungoogled = true;
          };
          librewolf.enable = true;
        };
        communication = {
          discord.enable = true;
          element.enable = true;
        };
        editors = {
          default = "emacs";
          emacs = {
            enable = true;
            wayland = true;
            daemon = true;
          };
          helix.enable = true;
        };
        entertainment = {
          games = {
            minecraft.enable = true;
            modding.enable = true;
          };
          music = {
            mpd = {
              enable = true;
              mpris = true;
              # rpc = true;
            };
            spotify.enable = true;
          };
        };
        shells = {
          bash.enable = true;
          fish = {
            enable = true;
            default = true;
          };
        };
        terminal-emulators = {
          ghostty.enable = true;
          kitty.enable = true;
          wezterm.enable = true;
        };
        utility = {
          ai.ollama.enable = true;
          direnv.enable = true;
          documents = {
            enable = true;
            latex = true;
            lilypond = true;
          };
          file-nav.enable = true;
          file-transfer.enable = true;
          fuzzy.enable = true;
          modern-alts.enable = true;
          multimedia.enable = true;
          # multiplex.enable = true;
          nix-utils.enable = true;
          obsidian.enable = true;
          vcs.enable = true;
        };
      };
    };
  };

  # Set the NixOS version from which
  # all default values are taken
  system.stateVersion = "22.11";
}
