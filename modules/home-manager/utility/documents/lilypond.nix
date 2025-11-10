{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.utility.documents.lilypond = lib.mkEnableOption "LilyPond";

  config = lib.mkIf config.heffos-home.utility.documents.lilypond {
    home.packages = with pkgs; [
      lilypond-with-fonts
    ];
  };
}
