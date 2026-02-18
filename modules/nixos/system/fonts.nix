{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.system.fonts.enable = lib.mkEnableOption "standard fonts";

  config = lib.mkIf config.heffos.system.fonts.enable {
    fonts.packages = with pkgs; [
      liberation_ttf
      (iosevka-bin.override {
        variant = "Aile";
      })
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-color-emoji
      symbola
    ];
  };
}
