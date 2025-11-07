{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.editors.emacs = {
    enable = lib.mkEnableOption "Emacs";
    wayland = lib.mkEnableOption "Emacs on Wayland";
    daemon = lib.mkEnableOption "the Emacs daemon";
  };

  config = lib.mkIf config.heffos-home.editors.emacs.enable (lib.mkMerge [
    {
      programs.emacs = {
        enable = true;
        package =
          if config.heffos-home.editors.emacs.wayland
          then pkgs.emacs-pgtk
          else pkgs.emacs;
        extraPackages = epkgs:
          with epkgs; [
            treesit-grammars.with-all-grammars
            tree-sitter-langs
            pdf-tools
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
    }
    (lib.mkIf config.heffos-home.editors.emacs.daemon {
      services.emacs = {
        enable = true;
        client = {
          enable = true;
          arguments = [
            "-c"
            "-a"
            "emacs"
          ];
        };
      };
    })
  ]);
}
