{lib, ...}: {
  imports = [
    ./delta.nix
    ./gh.nix
    ./gh-dash.nix
    ./lazygit.nix
  ];

  options.heffos-home.utility.vcs.enable = lib.mkEnableOption "utilities for version control systems";
}
