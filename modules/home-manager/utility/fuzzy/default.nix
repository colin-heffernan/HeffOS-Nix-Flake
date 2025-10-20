{lib, ...}: {
  imports = [
    ./fzf.nix
  ];

  options.heffos-home.utility.fuzzy.enable = lib.mkEnableOption "fuzzy-finder utilities";
}
