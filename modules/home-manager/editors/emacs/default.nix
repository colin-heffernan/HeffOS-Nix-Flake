{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.editors.emacs = {
    enable = lib.mkEnableOption "Emacs";
    daemon = lib.mkEnableOption "the Emacs daemon";
  };

  config = lib.mkMerge [
    (lib.mkIf config.heffos-home.editors.emacs.enable {
      programs.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
        extraPackages = epkgs:
          with epkgs; [
            treesit-grammars.with-all-grammars
            tree-sitter-langs
          ];
      };
      xdg.configFile."emacs/config.org" = {
        enable = true;
        source = ./config.org;
        onChange = ''
          ${pkgs.emacs-pgtk}/bin/emacs --batch \
          --eval "(require 'org)" \
          --eval '(org-babel-tangle-file "${config.xdg.configHome}/emacs/config.org")'
        '';
      };
    })
  ];
}
