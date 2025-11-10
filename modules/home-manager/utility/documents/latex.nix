{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.utility.documents.latex = lib.mkEnableOption "LaTeX";

  config = lib.mkIf config.heffos-home.utility.documents.latex {
    home.packages = with pkgs; [
      (texlive.combine {
        inherit (pkgs.texlive) scheme-minimal latex-bin latexmk;
      })
    ];
  };
}
