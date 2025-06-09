{
  # config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos
  ];

  # Set the PC hostname
  networking.hostName = "heffos-ikuyo";

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

  # Enable SSH
  services.openssh.enable = true;

  # Use the HeffOS module system
  heffos = {
    editors = {
      helix.enable = true;
      default = "helix";
    };
    shells = {
      fish.enable = true;
      zsh.enable = true;
    };
    utility = {
      direnv.enable = true;
      multimedia.enable = true;
      tty.enable = true;
    };
    services = {
      nix-gc.enable = true;
      polkit.enable = true;
    };
    system = {
      bootloader.rpi = {
        enable = true;
        version = 3;
      };
      connectivity = {
        wifi-networks = {
          a12.enable = true;
        };
        bluetooth.enable = true;
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
        "wheel"
      ];
      shell = pkgs.fish; # TODO: Revert to Zsh?
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
