{lib, ...}: {
  imports = [
    ./bat.nix
    ./eza.nix
  ];

  options.heffos-home.utility.modern-alts.enable = lib.mkEnableOption "modern alternatives to standard utilities";
}
