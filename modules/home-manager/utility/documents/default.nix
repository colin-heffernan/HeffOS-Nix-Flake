{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./latex.nix
    ./lilypond.nix
  ];

  options.heffos-home.utility.documents.enable = lib.mkEnableOption "utilities to handle text documents";

  config = lib.mkIf config.heffos-home.utility.documents.enable {
    home.packages = with pkgs; [
      pandoc
      poppler
    ];
  };
}
