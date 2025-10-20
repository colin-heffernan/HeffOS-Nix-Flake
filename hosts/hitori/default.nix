{
  # config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos
  ];

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

  # Disable SSH
  # This is false by default, but I think
  # specifying it is a decent idea anyway
  services.openssh.enable = false;

  # Use the HeffOS module system
  heffos = {
    config-dir = "/home/colin/Repos/HeffOS-Nix-Flake";
    theme.catppuccin.enable = true;
    compat = {
      translation.enable = true;
      virtualization.enable = true;
    };
    entertainment = {
      games = {
        gamemode.enable = true;
        steam.enable = true;
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
      desktop-environments.plasma.enable = true;
      display-managers.sddm.enable = true;
    };
    utility = {
      direnv.enable = true;
      file-nav.enable = true;
      fuzzy.enable = true;
      modern-alts.enable = true;
      multimedia.enable = true;
      multiplex.enable = true;
      nh.enable = true;
      notes.enable = true;
      vcs.enable = true;
    };
    services = {
      nix-gc.enable = true;
      polkit.enable = true;
      usb-automount.enable = true;
    };
    system = {
      bootloader.dualboot.enable = true;
      connectivity = {
        wifi-networks = {
          a12.enable = true;
        };
        bluetooth.enable = true;
      };
      fonts.enable = true;
      hardware-acceleration.enable = true;
      pipewire.enable = true;
      printing.enable = true;
      zram.enable = true;
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
      hashedPasswordFile = "/persist/passwords/colin";
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
          emacs.enable = true;
          helix.enable = true;
        };
        entertainment = {
          games = {
            minecraft.enable = true;
            modding.enable = true;
          };
          mpd = {
            enable = true;
            mpris = true;
            # rpc = true;
          };
        };
        shells = {
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
      };
    };
  };

  # Set the NixOS version from which
  # all default values are taken
  system.stateVersion = "22.11";
}
