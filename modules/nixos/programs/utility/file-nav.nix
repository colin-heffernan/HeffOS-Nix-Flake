{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.file-nav.enable = lib.mkEnableOption "file navigation utilities";

  config = lib.mkIf config.heffos.utility.file-nav.enable {
    environment.systemPackages = with pkgs; [
      yazi
      broot
      zoxide
      android-file-transfer
    ];
  };
}
