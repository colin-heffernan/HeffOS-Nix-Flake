{
  # config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos
  ];
  
  # Enable WSL
  wsl.enable = true;

  # Set the PC hostname
  networking.hostName = "heffos-futari";

  # Configure the time
  time.timeZone = "America/New_York";

  # Configure the firewall
  networking.firewall = {
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # Use the HeffOS module system
  heffos = {
    config-dir = "/home/colin/Repos/HeffOS-Nix-Flake";
    compat.translation.enable = true;
    editors = {
      helix.enable = true;
      default = "helix";
    };
    entertainment = {
      games = {
        gamemode.enable = true;
        minecraft.enable = true;
        modding.enable = true;
        steam.enable = true;
      };
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
      connectivity = {
        wifi-networks = {
          a12.enable = true;
        };
        bluetooth.enable = true;
      };
      hardware-acceleration.enable = true;
      pipewire.enable = true;
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
    };
  };

  # Set the NixOS version from which
  # all default values are taken
  system.stateVersion = "25.05";
}
