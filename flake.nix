{
  description = "Obsi's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      # url = "github:hyprwm/hyprland?rev=10b9e9bbe5fc71c5d7617776927c22db1167b10b";
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    discord = {
      type = "tarball";
      url = "https://discord.com/api/download/stable?platform=linux&format=tar.gz";
      flake = false;
    };
    nvcode = {
      url = "github:colin-heffernan/NVCode-Flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    discord,
    nvcode,
    helix,
    catppuccin-bat,
    catppuccin-btop,
    catppuccin-starship,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        nvcode.overlays.default
        (final: prev: {
          nix-direnv = prev.nix-direnv.override {enableFlakes = true;};
          helix = helix.packages.${prev.system}.helix-dev;
          discord = prev.discord.overrideAttrs (
            _: {src = inputs.discord;}
          );
          catppuccin-gtk = prev.catppuccin-gtk.override {
            accents = ["blue"];
            size = "compact";
            tweaks = ["rimless"];
            variant = "mocha";
          };
        })
      ];
    };
    inherit (nixpkgs) lib;
  in {
    nixosConfigurations = {
      heffos-obsidian = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {inherit nixpkgs;};
        modules = [
          hyprland.nixosModules.default
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit catppuccin-bat catppuccin-btop catppuccin-starship;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.obsi = import ./home.nix;
          }
        ];
      };
    };
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        lua-language-server
        nodePackages.vscode-langservers-extracted
      ];
    };
  };
}
