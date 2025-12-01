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
    defaultSopsFile = ../../secrets/ikuyo.yaml;
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

  # Soft-disable SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false; # Prevent logging in via password (only SSH keys work)
      PermitRootLogin = "no"; # Prevent root login entirely
    };
  };

  # Use the HeffOS module system
  heffos = {
    config-dir = "/home/colin/heffos";
    entertainment.games.minecraft-server.enable = true;
    system = {
      bootloader = {
        enable = true;
        rpi.enable = true;
      };
      connectivity = {
        wifi-networks = {
          a12.enable = true;
          whitesky.enable = true;
        };
        # bluetooth.enable = true;
        tailscale.enable = true;
      };
      nix-gc.enable = true;
      polkit.enable = true;
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
      hashedPasswordFile = config.sops.secrets.hashedPassword.path;
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
        editors.helix.enable = true;
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
          nix-utils.enable = true;
          vcs.enable = true;
        };
      };
    };
  };

  # Set the NixOS version from which
  # all default values are taken
  system.stateVersion = "22.11";
}
