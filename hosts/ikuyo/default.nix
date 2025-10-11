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
  networking.hostName = "heffos-ikuyo";

  # Configure the time
  time.timeZone = "America/New_York";

  # Swapfile
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];

  # Configure the firewall
  networking.firewall = {
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # Enable SSH
  services.openssh.enable = false;

  # Use the HeffOS module system
  heffos = {
    config-dir = "/home/colin/heffos";
    editors = {
      helix.enable = true;
      default = "helix";
    };
    shells.fish = {
      enable = true;
      default = true;
    };
    utility = {
      direnv.enable = true;
      file-nav.enable = true;
      fuzzy.enable = true;
      modern-alts.enable = true;
      nh.enable = true;
      vcs.enable = true;
    };
    services = {
      nix-gc.enable = true;
      polkit.enable = true;
    };
    system = {
      bootloader.rpi.enable = true;
      connectivity = {
        wifi-networks = {
          a12.enable = true;
          whitesky.enable = true;
        };
        # bluetooth.enable = true;
      };
    };
  };

  # Configure system users
  users = {
    mutableUsers = true;
    users.colin = {
      description = "Colin Heffernan";
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
      # hashedPasswordFile = "/persist/passwords/colin";
    };
  };

  # Configure Home Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    users.colin = {
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
    };
  };

  # Set the NixOS version from which
  # all default values are taken
  system.stateVersion = "22.11";
}
