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
            # Treesitter
            treesit-grammars.with-all-grammars
            tree-sitter-langs

            # Keybindings
            evil
            evil-collection
            evil-surround
            general

            # Completions
            vertico
            orderless
            marginalia
            consult
            embark
            embark-consult
            corfu
            cape

            # Navigation
            avy
            ace-window

            # UI
            catppuccin-theme
            ligature
            nerd-icons
            nerd-icons-ibuffer
            nerd-icons-completion
            nerd-icons-corfu
            solaire-mode
            doom-modeline
            hl-todo
            rainbow-mode
            rainbow-delimiters
            diff-hl
            popper
            olivetti

            # Languages
            format-all
            rust-mode
            zig-mode
            lispy
            lispyville
            fennel-mode
            kdl-mode
            nix-mode
            auctex
            auctex-latexmk
            pdf-tools
            # overtone/supercollider?
            markdown-mode

            # Org
            org-auto-tangle
            org-modern
            org-roam
            org-roam-ui
            toc-org

            # Apps
            transient
            magit
            # forge
            git-timemachine
            eat
            dirvish
            direnv
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
