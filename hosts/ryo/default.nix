{
  # config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos
  ];

  # Enable WSL
  wsl = {
    enable = true;
    defaultUser = "colin";
  };

  # Support VSCode remote
  programs.nix-ld.enable = true;

  # Set the PC hostname
  networking.hostName = "heffos-ryo";

  # Configure the time
  time.timeZone = "America/New_York";

  # Configure the firewall
  networking.firewall = {
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # Use the HeffOS module system
  heffos = {
    config-dir = "/home/colin/heffos";
    theme.catppuccin.enable = true;
    system = {
      nix-gc.enable = true;
    };
  };

  # Configure system users
  users = {
    mutableUsers = false;
    users.colin = {
      description = "Colin Heffernan";
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
      # hashedPasswordFile = "/persist/passwords/colin";
      initialPassword = "weedeater";
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
        editors = {
          emacs = {
            enable = true;
            daemon = true;
          };
          helix.enable = true;
        };
        shells = {
          bash.enable = true;
          fish = {
            enable = true;
            default = true;
          };
        };
        utility = {
          direnv.enable = true;
          file-nav.enable = true;
          fuzzy.enable = true;
          modern-alts.enable = true;
          nh.enable = true;
          vcs.enable = true;
        };
      };
    };
  };

  # Set the NixOS version from which
  # all default values are taken
  system.stateVersion = "25.05";
}
