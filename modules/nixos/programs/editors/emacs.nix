{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.editors.emacs.enable = lib.mkEnableOption "Emacs";

  config = lib.mkIf config.heffos.editors.emacs.enable {
    environment.systemPackages = with pkgs; [
      (
        (emacsPackagesFor emacs-pgtk).emacsWithPackages (
          epkgs: [
            (epkgs.treesit-grammars.with-all-grammars)
            epkgs.tree-sitter-langs
          ]
        )
      )
    ];
  };
}
