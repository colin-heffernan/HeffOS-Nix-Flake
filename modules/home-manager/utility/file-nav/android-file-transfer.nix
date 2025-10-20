{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.file-nav.enable {
    home.packages = with pkgs; [
      android-file-transfer
    ];
  };
}
