{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.editors.emacs.enable = lib.mkEnableOption "Emacs";

  config = lib.mkIf config.heffos.editors.emacs.enable {
    environment.systemPackages = with pkgs; [
      emacs-pgtk
    ];
    fonts.packages = with pkgs; [
      emacs-all-the-icons-fonts
    ];
  };
}
