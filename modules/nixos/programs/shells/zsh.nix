{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.shells.zsh.enable = lib.mkEnableOption "Z Shell";

  config = lib.mkIf config.heffos.shells.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$HOME/.config/zsh/histfile";
      shellAliases = {
        sup = "sudo nixos-rebuild switch --flake ~/Repos/HeffOS-Nix-Flake#${config.networking.hostName}";
        fup = "nix flake update";
      };
      syntaxHighlighting.enable = true;
      vteIntegration = true;
    };
  };
}
