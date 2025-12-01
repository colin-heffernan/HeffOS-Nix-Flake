{
  description = "HeffOS Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-dev.url = "github:colin-heffernan/nixpkgs";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake Parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # SOPS-Nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # Yazi Packages
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    # Nix-Minecraft
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Up-to-date Discord
    # discord = {
    #   type = "tarball";
    #   url = "https://discord.com/api/download/stable?platform=linux&format=tar.gz";
    #   flake = false;
    # };

    # Spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      # Specify systems
      # ARM's here! All hail the RPi!
      systems = ["x86_64-linux" "aarch64-linux"];

      # Import host configurations
      imports = [
        ./hosts
      ];

      # Run per-system code
      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };
    };
}
