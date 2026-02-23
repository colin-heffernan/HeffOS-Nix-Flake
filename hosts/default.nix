{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = {inherit self inputs;};
  in {
    # Main PC
    heffos-hitori = let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;

        # Allow unfree packages
        config.allowUnfree = true;

        # Set up overlays
        overlays = [
          inputs.audio.overlays.default # Audio plugins
          inputs.nix-minecraft.overlay # Inherit Nix-Minecraft
          (final: prev: {
            # Make `pkgs.stable` point to `nixos/nixpkgs/nixos-$STABLE`
            stable = import inputs.nixpkgs-stable {
              inherit (final) config;
              inherit (final.stdenv.hostPlatform) system;
            };
          })
        ];
      };
    in
      nixosSystem {
        inherit pkgs system specialArgs;
        modules = [
          ./hitori
        ];
      };

    # Raspberry Pi 3B+
    heffos-ikuyo = let
      system = "aarch64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;

        # Allow unfree packages
        config.allowUnfree = true;

        # Set up overlays
        overlays = [
          inputs.audio.overlays.default # Audio plugins
          inputs.nix-minecraft.overlay # Inherit Nix-Minecraft
          (final: prev: {
            # Make `pkgs.stable` point to `nixos/nixpkgs/nixos-$STABLE`
            stable = import inputs.nixpkgs-stable {
              inherit (final) config;
              inherit (final.stdenv.hostPlatform) system;
            };
          })
        ];
      };
    in
      nixosSystem {
        inherit pkgs system specialArgs;
        modules = [
          ./ikuyo
        ];
      };

    # WSL on main PC
    heffos-futari = let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;

        # Allow unfree packages
        config.allowUnfree = true;

        # Set up overlays
        overlays = [
          inputs.audio.overlays.default # Audio plugins
          inputs.nix-minecraft.overlay # Inherit Nix-Minecraft
          (final: prev: {
            # Make `pkgs.stable` point to `nixos/nixpkgs/nixos-$STABLE`
            stable = import inputs.nixpkgs-stable {
              inherit (final) config;
              inherit (final.stdenv.hostPlatform) system;
            };
          })
        ];
      };
    in
      nixosSystem {
        inherit pkgs system specialArgs;
        modules = [
          inputs.nixos-wsl.nixosModules.default
          ./futari
        ];
      };

    # WSL on laptop
    heffos-ryo = let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;

        # Allow unfree packages
        config.allowUnfree = true;

        # Set up overlays
        overlays = [
          inputs.audio.overlays.default # Audio plugins
          inputs.nix-minecraft.overlay # Inherit Nix-Minecraft
          (final: prev: {
            # Make `pkgs.stable` point to `nixos/nixpkgs/nixos-$STABLE`
            stable = import inputs.nixpkgs-stable {
              inherit (final) config;
              inherit (final.stdenv.hostPlatform) system;
            };
          })
        ];
      };
    in
      nixosSystem {
        inherit pkgs system specialArgs;
        modules = [
          inputs.nixos-wsl.nixosModules.default
          ./ryo
        ];
      };
  };
}
