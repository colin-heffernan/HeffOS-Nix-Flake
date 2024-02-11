{
  description = "Colin's system configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-dev.url = "github:colin-heffernan/nixpkgs";

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Up to date Discord
    discord = {
      type = "tarball";
      url = "https://discord.com/api/download/stable?platform=linux&format=tar.gz";
      flake = false;
    };

    # Quoted
    quoted = {
      url = "github:colin-heffernan/quoted";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Themes
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
    nixpkgs-dev,
    home-manager,
    discord,
    quoted,
    catppuccin-bat,
    catppuccin-btop,
    catppuccin-starship,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "steam"
            "steam-original"
            "steam-runtime"
          ];
      };
      overlays = [
        quoted.overlays.default
        (final: prev: {
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
    pkgs-dev = import nixpkgs-dev {inherit system;};
    inherit (nixpkgs) lib;
  in {
    nixosConfigurations = {
      heffos = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {inherit pkgs-dev catppuccin-starship;};
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit catppuccin-bat catppuccin-btop catppuccin-starship;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.colin = import ./home.nix;
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
