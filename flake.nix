{
  description = "HeffOS Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-dev.url = "github:colin-heffernan/nixpkgs";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake Parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Sops-Nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Up-to-date Discord
    discord = {
      type = "tarball";
      url = "https://discord.com/api/download/stable?platform=linux&format=tar.gz";
      flake = false;
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      # Specify systems
      # It's just x86-64 for now, but Flake Parts gives me
      # flexibility for later, in case I take on more architectures
      # Every night, I cry myself to sleep wishing ARM were here
      systems = ["x86_64-linux"];

      # Import host configurations
      imports = [
        ./hosts
      ];

      # Run per-system code
      perSystem = {pkgs, ...}: {
        # devShells.default = pkgs.mkShell {
        #   packages = with pkgs; [
        #     # Add packages here
        #   ];
        # };
        formatter = pkgs.alejandra;
      };
    };
}
