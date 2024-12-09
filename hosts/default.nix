{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    system = "x86_64-linux";

    pkgs = import inputs.nixpkgs {
      inherit system;

      # Allow unfree packages
      config.allowUnfree = true;

      # Set up overlays
      overlays = [
        (final: prev: {
          # Make `pkgs.stable` point to `nixos/nixpkgs/nixos-24.11`
          stable = inputs.nixpkgs-stable.legacyPackages.${prev.system};

          # Make `pkgs.dev` point to `colin-heffernan/nixpkgs`
          dev = inputs.nixpkgs-dev.legacyPackages.${prev.system};

          # Use the latest Discord tarball
          discord = prev.discord.overrideAttrs (
            _: {src = inputs.discord;}
          );
        })
      ];
    };

    lib = {
      inherit (inputs.nixpkgs) lib;
      mkIfElse = p: y: n:
        lib.mkMerge [
          (lib.mkIf p y)
          (lib.mkIf (!p) n)
        ];
      mkSwitch = l: lib.mkMerge (lib.lists.forEach l (p: c: lib.mkIf p c));
    };

    specialArgs = {inherit self inputs;};
  in {
    # Main PC
    heffos-hitori = nixosSystem {
      inherit pkgs lib system specialArgs;
      modules = [
        ./hitori
      ];
    };
  };
}
