{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.documents.enable = lib.mkEnableOption "utilities to handle text documents";

  config = lib.mkIf config.heffos.utility.documents.enable {
    environment.systemPackages = with pkgs; [
      pandoc
      poppler
      # TODO: Set up LaTeX?
    ];
  };
}
