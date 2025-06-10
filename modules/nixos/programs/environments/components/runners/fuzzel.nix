{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
in {
  options.heffos.environments.components.runners.fuzzel.enable = lib.mkEnableOption "Fuzzel";

  config = lib.mkIf config.heffos.environments.components.runners.fuzzel.enable {
    environment.systemPackages = with pkgs; [
      fuzzel
    ];
  };
}
