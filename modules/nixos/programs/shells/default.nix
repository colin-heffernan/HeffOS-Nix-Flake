{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  imports = [
    ./fish.nix
    ./zsh.nix
  ];

  config = lib.mkIf (config.heffos.shells.fish.enable || config.heffos.shells.zsh.enable) {
    # FIXME: Fix Starship config
    # programs.starship.enable = true;
  };
}
