{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./communication
    ./compat
    ./entertainment
    ./environments
    ./shells
    ./terminal-emulators
    ./utility
  ];

  # Configure Nix
  nix = {
    # package = pkgs.lix;
    registry = let
      flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
    in
      lib.mapAttrs (_: v: {flake = v;}) flakeInputs;
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      accept-flake-config = false;
    };
  };

  # Configure Git
  programs.git = {
    enable = true;
    config.init.defaultBranch = "main";
  };

  # Add dev documentation
  documentation.dev.enable = true;

  # Start the SSH agent to automatically load keys
  programs.ssh.startAgent = true;

  # Ensure that these basic tools are always installed
  environment.systemPackages = with pkgs; [
    # Web requests
    curl
    wget

    # Archival tools
    zip
    unzip
    p7zip

    # Coreutils alternatives
    ripgrep
    ripgrep-all
    fd

    # System tools
    bottom
    trash-cli

    # Common language tools
    nodePackages.bash-language-server
    nil
    nixd
    alejandra
  ];
}
