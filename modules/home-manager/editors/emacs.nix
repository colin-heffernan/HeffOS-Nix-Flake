{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO: Add modules for Emacs daemon
  options.heffos-home.editors.emacs.enable = lib.mkEnableOption "Emacs";

  config = lib.mkIf config.heffos-home.editors.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = epkgs:
        with epkgs; [
          treesit-grammars.with-all-grammars
          tree-sitter-langs
        ];
    };
  };
}
