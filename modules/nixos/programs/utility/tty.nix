{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.tty.enable = lib.mkEnableOption "TTY-friendly utilities";

  config = lib.mkIf config.heffos.utility.tty.enable {
    environment.systemPackages = with pkgs; [
      zellij
      file
      wl-clipboard
      android-file-transfer
      pandoc
    ];
  };
}
