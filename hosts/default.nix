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
          (final: prev: {
            # Make `pkgs.stable` point to `nixos/nixpkgs/nixos-$STABLE`
            stable = import inputs.nixpkgs-stable {
              system = final.system;
              config = final.config;
            };

            # Make `pkgs.dev` point to `colin-heffernan/nixpkgs`
            dev = import inputs.nixpkgs-dev {
              system = final.system;
              config = final.config;
            };

            # Use the latest Discord tarball
            discord = prev.discord.overrideAttrs (
              _: {src = inputs.discord;}
            );
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
  };
}
