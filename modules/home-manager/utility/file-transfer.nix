{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.utility.file-transfer.enable = lib.mkEnableOption "file transfer utilities";

  config = lib.mkIf config.heffos-home.utility.file-transfer.enable {
    home.packages = with pkgs; [
      deluge
      nicotine-plus
      # deluged
      # slskd
    ];
  };
}
