{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./compat
    ./entertainment
    ./environments
    ./system
    ./theme
    ./utility
  ];

  options.heffos.config-dir = lib.mkOption {
    type = lib.types.path;
    description = "The directory that contains the HeffOS flake.";
  };

  config = {
    # Configure Git
    programs.git = {
      enable = true;
      lfs.enable = true;
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
      nixd
      alejandra
    ];
  };
}
