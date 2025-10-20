{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # TODO: Setup LaTeX
    # ./latex.nix
  ];

  options.heffos-home.utility.documents = {
    enable = lib.mkEnableOption "utilities to handle text documents";
    latex = lib.mkEnableOption "LaTeX";
  };

  config = lib.mkIf config.heffos-home.utility.documents.enable {
    home.packages = with pkgs; [
      pandoc
      poppler
    ];
  };
}
