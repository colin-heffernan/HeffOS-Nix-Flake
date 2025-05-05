{pkgs, ...}: {
  imports = [
    ./browsers
    ./communication
    ./compat
    ./editors
    ./entertainment
    ./environments
    ./shells
    ./terminal-emulators
    ./utility
  ];

  # Configure Nix
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # TODO: Ensure this part works before
    # enabling it and destroying a system
    /*
    registry.nixpkgs.to = {
      type = "path";
      path = pkgs.path;
      narHash = pkgs.narHash;
    };
    */
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
    curl
    wget
    zip
    unzip
    p7zip
    hyfetch
    btop
    nodePackages.bash-language-server
    nil
    nixd
    alejandra
    nvd
  ];

  # Ensure that these fonts are always installed
  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    noto-fonts
    noto-fonts-color-emoji
  ];
}
