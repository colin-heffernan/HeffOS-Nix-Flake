{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./bat.nix
    ./eza.nix
  ];

  options.heffos-home.utility.modern-alts.enable = lib.mkEnableOption "modern alternatives to standard utilities";

  config = lib.mkIf config.heffos-home.utility.modern-alts.enable {
    home.packages = with pkgs; [
      dust
    ];
  };
}
