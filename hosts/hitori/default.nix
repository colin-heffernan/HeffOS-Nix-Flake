{
  # config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    ../../modules/nixos
  ];

  # Import secrets
  # FIXME: Fix `sops-nix`
  /*
  sops = {
    defaultSopsFile = ../../secrets/hitori.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/persist/keys/sops-nix";
    secrets = {
      "users/colin/password".neededForUsers = true;
      "wireless.conf".owner = config.users.users.colin.name;
    };
  };
  */

  # Set the PC hostname
  networking.hostName = "heffos-hitori";

  # Configure the time
  # FIXME: Support dualboot nicely
  time.timeZone = "America/New_York";

  # Configure the firewall
  # TODO: Maybe use `sops-nix` to store ports?
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
    browsers.firefox.enable = true;
    communication = {
      discord.enable = true;
      matrix.enable = true;
    };
    compat = {
      translation.enable = true;
      virtualization.enable = true;
    };
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
      freetube.enable = true;
    };
    environments.plasma.enable = true;
    shells = {
      fish.enable = true;
      zsh.enable = true;
    };
    terminal-emulators = {
      kitty.enable = true;
      wezterm.enable = true;
    };
    utility = {
      direnv.enable = true;
      multimedia.enable = true;
      no-tty.enable = true;
      tty.enable = true;
    };
    services = {
      pipewire.enable = true;
      polkit.enable = true;
    };
    system = {
      connectivity = {
        wifi-networks = {
          a12.enable = true;
          eduroam.enable = true;
        };
        bluetooth.enable = true;
      };
      hardware-acceleration.enable = true;
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
      shell = pkgs.fish; # TODO: Revert to Zsh?
      # FIXME: Fix `sops-nix` and set hashedPasswordFile to `config.sops.secrets."users/colin/password".path`
      hashedPasswordFile = "/persist/passwords/colin";
    };
  };

  # Configure Home Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
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
        # FIXME: This might explode
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
