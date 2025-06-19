{
  config,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./zsh.nix
  ];

  options.heffos.shells.aliases = lib.mkOption {
    type = lib.types.attrs;
    description = "List of shell aliases to use.";
    default = {
      sup = "sudo nixos-rebuild switch --flake ~/Repos/HeffOS-Nix-Flake#${config.networking.hostName}";
      fup = "nix flake update";
    };
  };

  config = lib.mkIf (config.heffos.shells.fish.enable || config.heffos.shells.zsh.enable) {
    programs.starship.enable = true;
  };
}
