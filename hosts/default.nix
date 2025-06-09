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
        # Enable the NUR
        inputs.nur.overlays.default

        (final: prev: {
          # Make `pkgs.stable` point to `nixos/nixpkgs/nixos-25.05`
          stable = inputs.nixpkgs-stable.legacyPackages.${prev.system};

          # Make `pkgs.dev` point to `colin-heffernan/nixpkgs`
          dev = inputs.nixpkgs-dev.legacyPackages.${prev.system};

          # Use zjstatus
          zjstatus = inputs.zjstatus.packages.${prev.system}.default;

          # Use the latest Discord tarball
          discord = prev.discord.overrideAttrs (
            _: {src = inputs.discord;}
          );
        })
      ];
    };

    specialArgs = {inherit self inputs;};
  in {
    # Main PC
    heffos-hitori = nixosSystem {
      inherit pkgs system specialArgs;
      modules = [
        ./hitori
      ];
    };
  };
}
