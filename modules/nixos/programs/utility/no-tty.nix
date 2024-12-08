{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.no-tty.enable = lib.mkEnableOption "TTY-unfriendly utilities";

  config = lib.mkIf config.heffos.utility.no-tty.enable {
    environment.systemPackages = with pkgs; [
      eza
      lazygit
      lf
      pistol
    ];
  };
}
